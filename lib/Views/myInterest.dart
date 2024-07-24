import 'package:event_music_app/Views/BandDetail/bandDetail.dart';
import 'package:event_music_app/data/band_model.dart';
import 'package:flutter/material.dart';
import '../Constants/colors.dart';
import '../Helper/firestore_database_helper.dart';
import '../Helper/shared_preference_helper.dart';
import '../Helper/texts.dart';
import '../data/login_response.dart';
import '../widgets/divider.dart';

class MyInterest extends StatefulWidget {
  const MyInterest({super.key});

  @override
  State<MyInterest> createState() => _MyInterestState();
}

class _MyInterestState extends State<MyInterest> {
  List<BandModel> interestedBands = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    fetchInterestedBands();
    super.initState();
  }

  Future<void> fetchInterestedBands() async {
    try {
      final allBands = await FirestoreDatabaseHelper.instance().getBands();
      LoginResponse? user = await SharedPreferenceHelper.instance().user;

      if (allBands != null && user != null) {
        setState(() {
          interestedBands = allBands.where((band) {
            return user.interested.contains(band.uuId);
          }).toList();
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primary, black])),
            child: Column(children: [
              SizedBox(height: 40),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios, color: white)))),
                Padding(
                  padding: const EdgeInsets.only(right: 20,top: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Image.asset('assets/icons/heart.png', color: white),
                          SizedBox(width: 5),
                          Text('My Interest', style: t24)
                        ]),
                        Text('Your favourite brand', style: Lightt14)
                      ]),
                ),
                SizedBox()
              ]),
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
                interestedBands.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/heart_big.png', color: white, width: 100, height: 100),
                                SizedBox(height: 20),
                                Text(
                                    'Not found any interested bands right now if swipe left some bands in bands screen then your interested band show here ...',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20, color: Colors.white)),
                              ],
                            )))
                    : ListView.separated(
                        separatorBuilder: (_, __) => divider(),
                        itemCount: interestedBands.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final band = interestedBands[index];
                          return ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) => BandDetails(bandModel: band)));
                              },
                              leading: band.image.isEmpty
                                  ? CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/bands.png'))
                                  : CircleAvatar(radius: 30, backgroundImage: NetworkImage(band.image)),
                              title: Text(band.name, style: Boldt16),
                              subtitle: Text(band.profileId, style: Lightt12));
                        })
            ])));
  }
}
