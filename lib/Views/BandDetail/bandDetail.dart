import 'package:event_music_app/Views/BandDetail/mp3.dart';
import 'package:event_music_app/Views/UpComingEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../Constants/colors.dart';
import '../../Helper/texts.dart';
import '../../widgets/divider.dart';
import '../Uploads/VideosUpload.dart';
import '../Uploads/trackUpload.dart';

class BandDetails extends StatefulWidget {
  const BandDetails({super.key});

  @override
  State<BandDetails> createState() => _BandDetailsState();
}

class _BandDetailsState extends State<BandDetails> {
  bool switchButton = false;
  List videos = [
    'assets/video.png',
    'assets/video1.png',
    'assets/video2.png',
    'assets/video3.png',
  ];
  List photo = [
    'assets/Rectangle 17 (1).png',
    'assets/Rectangle 17 (2).png',
    'assets/Rectangle 17 (3).png',
    'assets/Rectangle 18 (1).png',
    'assets/Rectangle 18 (2).png',
    'assets/Rectangle 19 (1).png',
    'assets/Rectangle 19 (2).png',
    'assets/Rectangle 19 (3).png',
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primary, black])),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Text(
                    'Band Name  ',
                    style: t24,
                  ),
                  Image.asset('assets/icons/more.png')
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/bands.png'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '@band_id',
              style: Regulart16,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Band Bio Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
                style: Lightt12,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: mediumWhite,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Members',
                        style: Lightt12,
                      ),
                      Text(
                        '10 Members',
                        style: Boldt16,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 60,
                    child: VerticalDivider(
                      thickness: 2,
                      color: white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        'Genre',
                        style: Lightt12,
                      ),
                      Text(
                        'Rock, Soft, Traditional',
                        style: Boldt16,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => UpComingEvents()));
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: white),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/message.png',
                            color: black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Message',
                            style: TextStyle(),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Row(
                children: [
                  Image.asset('assets/icons/facebook.png'),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset('assets/icons/link.png'),
                  SizedBox(
                    width: 10,
                  ),
                  Text('google.com',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: white,
                        fontSize: 14,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      RatingBar(
                        itemSize: 20,
                        initialRating: 4,
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
                      Text(
                        '  4.5',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: yellow,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'View Feedback',
                        style: Lightt14,
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: white,
                            size: 30,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                color: white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      surfaceVariant: Colors.transparent,
                    ),
              ),
              child: TabBar(
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 45),
                  padding: EdgeInsets.only(bottom: 10),
                  indicatorColor: blue,
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: lightWhite,
                  labelColor: white,
                  automaticIndicatorColorAdjustment: false,
                  tabs: [
                    Text('Tracks'),
                    Text('Music Videos'),
                    Text('Photos'),
                  ]),
            ),
            Expanded(
              child: TabBarView(children: [
                Mp3(),
                GridView.builder(
                    itemCount: videos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0),
                    itemBuilder: (_, i) {
                      return Container(
                          color: red,
                          child: Image.asset(
                            videos[i],
                            fit: BoxFit.cover,
                          ));
                    }),
                GridView.builder(
                    itemCount: photo.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0),
                    itemBuilder: (_, i) {
                      return Container(
                          color: red,
                          child: Image.asset(
                            photo[i],
                            fit: BoxFit.cover,
                          ));
                    }),
              ]),
            ),
          ],
        ),
      )),
    );
  }
}
