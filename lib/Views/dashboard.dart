import 'package:audioplayers/audioplayers.dart';
import 'package:event_music_app/Helper/texts.dart';
import 'package:event_music_app/Views/BandDetail/bandDetail.dart';
import 'package:event_music_app/Views/myInterest.dart';
import 'package:event_music_app/data/band_model.dart';
import 'package:flutter/material.dart';
import '../Constants/colors.dart';
import '../Helper/firestore_database_helper.dart';
import '../Helper/shared_preference_helper.dart';
import '../data/login_response.dart';
import '../widgets/button.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  bool isPlaying = false;
  int currentIndex = -1;
  String errorMessage = '';
  List<BandModel>? bands = [];

  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  Future<void> getBands() async {
    try {
      final allBands = await FirestoreDatabaseHelper.instance().getBands();
      LoginResponse? user = await SharedPreferenceHelper.instance().user;

      if (allBands == null) {
        setState(() {
          isLoading = false;
          errorMessage = 'Band not found right now';
        });
        return;
      }

      if (user == null) {
        setState(() {
          isLoading = false;
          errorMessage = 'User not found';
        });
        return;
      }

      List<BandModel> filteredBands = allBands.where((band) {
        return !user.interested.contains(band.uuId) && !user.notInterested.contains(band.uuId);
      }).toList();

      print('filter bands====>${filteredBands.length}');
      setState(() {
        bands = filteredBands;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  @override
  void initState() {
    getBands();
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted)
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
    });
    if (mounted)
      _audioPlayer.onDurationChanged.listen((Duration duration) {
        setState(() {
          totalDuration = duration;
        });
      });
    if (mounted)
      _audioPlayer.onPositionChanged.listen((Duration position) {
        setState(() {
          currentPosition = position;
        });
      });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause(String url, int index) async {
    if (isPlaying && currentIndex == index) {
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      if (currentIndex != index) {
        await _audioPlayer.stop();
        await _audioPlayer.play(UrlSource(url));
      } else {
        await _audioPlayer.resume();
      }
      setState(() {
        isPlaying = true;
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: Container(
              decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 50, 109, 168), offset: Offset(0, 2.0), spreadRadius: 30, blurRadius: 40)
          ]))),
      body: Column(
        children: [
          if (isLoading)
            SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                child: Center(child: CircularProgressIndicator())) // Show loading indicator
          else if (errorMessage.isNotEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                    child: Text(errorMessage,
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white))),
              ),
            )
          else
            bands!.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                          child: Text('Not found any bands right now if create band then show here ...',
                              textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white))),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: bands!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final band = bands![index];

                          return bands!.length < 2 && band.tracks.isEmpty
                              ? SizedBox(
                                  height: MediaQuery.of(context).size.height / 1.5,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Center(
                                        child: Text('Not found any bands right now if create band then show here ...',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 20, color: Colors.white))),
                                  ),
                                )
                              : band.tracks.isEmpty
                                  ? SizedBox()
                                  : GestureDetector(
                                      onHorizontalDragEnd: (details) {
                                        if (details.primaryVelocity! > 0) {
                                          _showTransparentDialog(context, details.primaryVelocity!, band);
                                        } else if (details.primaryVelocity! < 0) {
                                          _showTransparentDialog(context, details.primaryVelocity!, band);
                                        }
                                      },
                                      child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height * 0.85,
                                          child: Stack(alignment: Alignment.topCenter, children: [
                                            band.tracks.first.image.isEmpty
                                                ? Image.asset(
                                                    'assets/Rectangle 9.png',
                                                    height: 380,
                                                    width: MediaQuery.of(context).size.width,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.network(
                                                    band.tracks.first.image,
                                                    height: 380,
                                                    width: MediaQuery.of(context).size.width,
                                                    fit: BoxFit.fill,
                                                  ),
                                            Positioned(
                                                bottom: 0,
                                                child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                                    width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(
                                                      color: primary,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color.fromARGB(255, 50, 109, 168),
                                                            spreadRadius: 30,
                                                            blurRadius: 40)
                                                      ],
                                                    ),
                                                    child:
                                                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                      Text(
                                                        band.tracks.first.title,
                                                        style: t24,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        band.tracks.first.singers,
                                                        style: Lightt14,
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      Slider(
                                                        activeColor: white,
                                                        inactiveColor: lightWhite,
                                                        value: currentPosition.inSeconds.toDouble(),
                                                        max: totalDuration.inSeconds.toDouble(),
                                                        onChanged: (double value) async {
                                                          final position = Duration(seconds: value.toInt());
                                                          await _audioPlayer.seek(position);
                                                          if (!isPlaying) {
                                                            _audioPlayer.pause();
                                                          }
                                                        },
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              _formatDuration(currentPosition),
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                            Text(
                                                              _formatDuration(totalDuration),
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            _togglePlayPause(band.tracks.first.file, index);
                                                          },
                                                          icon: Icon(
                                                            isPlaying && currentIndex == index
                                                                ? Icons.pause_circle_filled
                                                                : Icons.play_circle_filled,
                                                            size: 50,
                                                            color: white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                builder: (_) => BandDetails(bandModel: band)));
                                                          },
                                                          child: Row(children: [
                                                            band.image.isEmpty
                                                                ? CircleAvatar(
                                                                    radius: 30,
                                                                    backgroundImage: AssetImage('assets/bands.png'))
                                                                : CircleAvatar(
                                                                    radius: 30,
                                                                    backgroundImage: NetworkImage(band.image)),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Column(children: [
                                                              Text(
                                                                band.name,
                                                                style: Boldt16,
                                                              ),
                                                              Text(band.profileId,
                                                                  textAlign: TextAlign.left, style: Lightt11)
                                                            ])
                                                          ])),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        band.description,
                                                        style: Lightt12,
                                                      ),
                                                      SizedBox(height: 20)
                                                    ])))
                                          ])));
                        }),
                  ),
        ],
      ),
    );
  }

  Future<void> _showTransparentDialog(BuildContext context, double detail, BandModel band) async {
    final isInterested = detail < 0;
    print('isintrested===>$isInterested');

    LoginResponse? user = await SharedPreferenceHelper.instance().user;

    if (user == null) return; // Handle case if user is not available

    List<String> updatedInterestList = List.of(user.interested);
    List<String> updatedNotInterestedList = List.of(user.notInterested);

    if (isInterested) {
      if (!updatedInterestList.contains(band.uuId)) {
        updatedInterestList.add(band.uuId);
      }
      updatedNotInterestedList.remove(band.uuId);
    } else {
      if (!updatedNotInterestedList.contains(band.uuId)) {
        updatedNotInterestedList.add(band.uuId);
      }
      updatedInterestList.remove(band.uuId);
    }

    // Update user data in SharedPreferences
    user = user.copyWith(
      interested: updatedInterestList,
      notInterested: updatedNotInterestedList,
    );
    await SharedPreferenceHelper.instance().insertUser(user);

    // Update user data in Firebase
    await FirestoreDatabaseHelper.instance().updateUser(user);

    // Optionally remove the band from the list
    setState(() {
      bands?.remove(band);
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(isInterested ? 'assets/icons/heart_big.png' : 'assets/icons/heart-slash.png'),
                SizedBox(height: 50),
                Text(isInterested ? 'Added to \nInterest' : 'Not \n Interested',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: white, fontSize: 40, fontWeight: FontWeight.bold)),
                if (isInterested) SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                if (isInterested)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: MyButton(
                      color: primary,
                      name: 'See your interest',
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyInterest()));
                      },
                    ),
                  ),
                if (isInterested)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                if (isInterested)
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Continue',
                        style: Boldt16,
                      ))
              ])));
        });
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
