import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

import '../Constants/colors.dart';
import '../Helper/texts.dart';

class VenueDetail extends StatelessWidget {
  const VenueDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, right: 10, left: 10),
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/image.png',
                      ),
                      fit: BoxFit.cover),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: white,
                        )),
                    Image.asset(
                      'assets/icons/more.png',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 180,
                child: Container(
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
                        height: 50,
                      ),
                      Text(
                        'Venue Name',
                        style: t20,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        '@profile_id',
                        style: Lightt14,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/location.png',
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Warren, OH Packard Music Hall',
                              style: Regulart14,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              'Description',
                              textAlign: TextAlign.start,
                              style: Regulart16,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ReadMoreText(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
                          trimLines: 2,
                          colorClickableText: blue,
                          style: Lightt12,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Read more',
                          trimExpandedText: 'Read less',
                          moreStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: blue),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          )
                        ],
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (c, i) {
                              return Container(
                                width: 300,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                padding: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: lightWhite),
                                  color: mediumWhite,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Profile Name',
                                              style: Regulart16,
                                            ),
                                            Text(
                                              '@profile_id',
                                              style: Lightt11,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: white,
                                    ),
                                    Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do',
                                      style: Lightt12,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              'Location',
                              style: Boldt16,
                            ),
                          ],
                        ),
                      ),
                      Image.asset('assets/map.png')
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                child: CircleAvatar(
                  radius: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
