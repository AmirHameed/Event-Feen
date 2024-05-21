import 'package:event_music_app/Helper/texts.dart';
import 'package:event_music_app/Views/BandDetail/bandDetail.dart';
import 'package:event_music_app/Views/myInterest.dart';
import 'package:flutter/material.dart';

import '../Constants/colors.dart';
import '../widgets/button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List images = [
    'assets/Rectangle 9.png',
    'assets/Rectangle 9 (1).png',
    'assets/Rectangle 9 (2).png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 50, 109, 168),
                    offset: Offset(0, 2.0),
                    spreadRadius: 30,
                    blurRadius: 40)
              ],
            ),
          )),
      body: ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  // User swiped right
                  _showTransparentDialog(context, details.primaryVelocity!);
                } else if (details.primaryVelocity! < 0) {
                  // User swiped left
                  _showTransparentDialog(context, details.primaryVelocity!);
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      images[i],
                      height: 380,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'This Thing of Ours',
                              style: t24,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Song by Omarion and Wale',
                              style: Lightt14,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 30,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: lightWhite,
                                      borderRadius: BorderRadius.circular(10)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.play_arrow_rounded,
                                    size: 50,
                                    color: white,
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => BandDetails()));
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('assets/bands.png')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Band Name',
                                        style: Boldt16,
                                      ),
                                      Text(
                                        '@profile_id',
                                        textAlign: TextAlign.left,
                                        style: Lightt11,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
                              style: Lightt12,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _showTransparentDialog(BuildContext context, double detail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            // Adjust dialog content here

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(detail < 0
                    ? 'assets/icons/heart_big.png'
                    : 'assets/icons/heart-slash.png'),
                SizedBox(
                  height: 50,
                ),
                Text(
                  detail < 0 ? 'Added to \nInterest' : 'Not \n Interested',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: white, fontSize: 40, fontWeight: FontWeight.bold),
                ),
                if (detail < 0)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                if (detail < 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: MyButton(
                      color: primary,
                      name: 'See your interest',
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => MyInterest()));
                      },
                    ),
                  ),
                if (detail < 0)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                if (detail < 0)
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Continue',
                      style: Boldt16,
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
