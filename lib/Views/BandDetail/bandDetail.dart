import 'package:chewie/chewie.dart';
import 'package:event_music_app/Views/BandDetail/mp3.dart';
import 'package:event_music_app/Views/UpComingEvents.dart';
import 'package:event_music_app/data/band_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:video_player/video_player.dart';
import '../../Constants/colors.dart';
import '../../Helper/texts.dart';

class BandDetails extends StatefulWidget {
  BandModel bandModel;

  BandDetails({super.key, required this.bandModel});

  @override
  State<BandDetails> createState() => _BandDetailsState();
}

class _BandDetailsState extends State<BandDetails> {
  bool switchButton = false;

  @override
  Widget build(BuildContext context) {
    final band = widget.bandModel;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            body: Container(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primary, black])),
                child: Column(children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: white,
                              )),
                        ),
                        Text('${band.name}  ', style: t24),
                        Image.asset('assets/icons/more.png')
                      ])),
                  SizedBox(height: 10),
                  band.image.isEmpty
                      ? CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/bands.png'))
                      : CircleAvatar(radius: 50, backgroundImage: NetworkImage(band.image)),
                  SizedBox(height: 10),
                  Text(band.profileId, style: Regulart16),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(band.description, style: Lightt12)),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mediumWhite,
                      ),
                      child: Row(children: [
                        Column(children: [
                          Text(
                            'Members',
                            style: Lightt12,
                          ),
                          Text(
                            '${band.totalMember} Members',
                            style: Boldt16,
                          )
                        ]),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(height: 60, child: VerticalDivider(thickness: 2, color: white)),
                        SizedBox(width: 20),
                        Column(children: [
                          Text(
                            'Genre',
                            style: Lightt12,
                          ),
                          Text(
                            band.genre.join(', '),
                            style: Boldt16,
                          )
                        ])
                      ])),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpComingEvents()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: white,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/calendar.png',
                              color: white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'See Events',
                              style: Lightt12,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
                        child: Column(children: [
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Image.asset(
                              'assets/icons/message.png',
                              color: black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Message', style: TextStyle())
                          ])
                        ]))
                  ]),
                  Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Row(children: [
                        Image.asset('assets/icons/facebook.png'),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset('assets/icons/link.png'),
                        SizedBox(
                          width: 10,
                        ),
                        Text(band.googleLink,
                            style: TextStyle(decoration: TextDecoration.underline, color: white, fontSize: 14))
                      ])),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(children: [
                              RatingBar(
                                itemSize: 20,
                                initialRating: band.totalRating,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                ratingWidget: RatingWidget(
                                  full: Image.asset('assets/icons/star.png'),
                                  half: Image.asset('assets/icons/star1.png'),
                                  empty: Image.asset('assets/icons/starB.png'),
                                ),
                                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Text('  ${band.totalRating}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18, color: yellow, fontWeight: FontWeight.w500))
                            ]),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                setState(() {
                                  switchButton = !switchButton;
                                });
                              },
                              child: Row(children: [
                                Text(
                                  'View Feedback',
                                  style: Lightt14,
                                ),
                                Icon(switchButton ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: white, size: 30)
                              ]),
                            )
                          ])),
                  !switchButton
                      ? SizedBox()
                      : Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 10),
                              itemCount: band.reviews.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (c, index) {
                                final review = band.reviews[index];
                                return Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: review.image.isEmpty
                                                    ? AssetImage('assets/profile.png')
                                                    : NetworkImage(review.image) as ImageProvider,
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                  Text(
                                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
                                                      style: Lightt11),
                                                  SizedBox(height: 10),
                                                  Text(review.dateTime.toString(), style: Lightt11)
                                                ]),
                                              )
                                            ]),
                                        Divider(
                                          thickness: 1,
                                          color: white.withOpacity(0.2),
                                        )
                                      ]),
                                );
                              }),
                        ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Divider(color: white)),
                  SizedBox(height: 10),
                  Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(surfaceVariant: Colors.transparent)),
                      child: TabBar(
                          indicatorPadding: EdgeInsets.symmetric(horizontal: 45),
                          padding: EdgeInsets.only(bottom: 10),
                          indicatorColor: blue,
                          dividerColor: Colors.transparent,
                          unselectedLabelColor: lightWhite,
                          labelColor: white,
                          automaticIndicatorColorAdjustment: false,
                          tabs: [Text('Tracks'), Text('Music Videos'), Text('Photos')])),
                  Expanded(
                      child: TabBarView(children: [
                    band.tracks.isEmpty
                        ? Center(child: Text('Not tracks upload yet .when band uploaded tracks its show here...'))
                        : Mp3(tracks: band.tracks),
                    band.videos.isEmpty
                        ? Center(child: Text('Not videos upload yet .when band uploaded videos its show here...'))
                        : GridView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: band.videos.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, crossAxisSpacing: 0, mainAxisSpacing: 0),
                            itemBuilder: (_, i) {
                              Video video = band.videos[i];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VideoPlayerScreen(videoUrl: video.file)));
                                  },
                                  child: Stack(children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: red,
                                            image: DecorationImage(
                                                image: video.image.isEmpty
                                                    ? AssetImage('assets/placeholder.png')
                                                    : NetworkImage(video.image) as ImageProvider,
                                                fit: BoxFit.cover))),
                                    Center(child: Icon(Icons.play_circle_filled, color: Colors.white, size: 50))
                                  ]));
                            }),
                    band.photos.isEmpty
                        ? Center(child: Text('Not photos upload yet .when band uploaded photos its show here...'))
                        : GridView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: band.photos.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, crossAxisSpacing: 0, mainAxisSpacing: 0),
                            itemBuilder: (_, i) {
                              return Container(
                                  decoration: BoxDecoration(
                                      color: red,
                                      image: DecorationImage(
                                          image: band.photos[i].isEmpty
                                              ? AssetImage('assets/placeholder.png')
                                              : NetworkImage(band.photos[i]) as ImageProvider,
                                          fit: BoxFit.cover)));
                            }),
                  ]))
                ]))));
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Colors.black),
        body: Center(child: Chewie(controller: _chewieController)));
  }
}
