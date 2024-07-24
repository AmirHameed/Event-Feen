import 'package:event_music_app/data/band_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

import '../Constants/colors.dart';
import '../Helper/texts.dart';

class VenueDetail extends StatelessWidget {
  BandModel venue;

  VenueDetail({super.key, required this.venue});

  final String apiKey = 'AIzaSyAZi4SG3M_Hut73GeIxlbkeEK1iziodxec';

  @override
  Widget build(BuildContext context) {
    String mapUrl = staticMapUrl(
      latitude: venue.lat,
      longitude: venue.long,
      width: 600,
      height: 300,
      apiKey: apiKey,
    );

    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Stack(alignment: Alignment.center, clipBehavior: Clip.none, children: [
              Container(
                  padding: EdgeInsets.only(top: 20, right: 10, left: 10),
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: venue.image.isEmpty
                            ? AssetImage('assets/image.png')
                            : NetworkImage(venue.image) as ImageProvider,
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20),
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
                            Image.asset('assets/icons/more.png', fit: BoxFit.cover)
                          ]))),
              Positioned(
                  top: 180,
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primary, black])),
                      child: Column(children: [
                        SizedBox(height: 50),
                        Text(venue.name, style: t20),
                        SizedBox(height: 2),
                        Text(venue.profileId, style: Lightt14),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(children: [
                              Image.asset('assets/icons/location.png', width: 20, height: 20, color: Colors.white),
                              SizedBox(width: 5),
                              Text(venue.location, style: Regulart14)
                            ])),
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
                            venue.description,
                            trimLines: 2,
                            colorClickableText: blue,
                            style: Lightt12,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Read more',
                            trimExpandedText: 'Read less',
                            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: blue),
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
                              initialRating: venue.totalRating,
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
                              '  ${venue.totalRating}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18, color: yellow, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        SizedBox(
                            height: 200,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: venue.reviews.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (c, index) {
                                  final review = venue.reviews[index];
                                  return Container(
                                      width: 300,
                                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: lightWhite),
                                        color: mediumWhite,
                                      ),
                                      child: Column(children: [
                                        Row(children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundImage: review.image.isEmpty
                                                ? AssetImage('assets/profile.png')
                                                : NetworkImage(review.image) as ImageProvider,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(children: [
                                            Text(
                                              review.name,
                                              style: Regulart16,
                                            ),
                                            Text(review.profileId, style: Lightt11)
                                          ])
                                        ]),
                                        Divider(
                                          thickness: 1,
                                          color: white,
                                        ),
                                        Text(review.description, style: Lightt12)
                                      ]));
                                })),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(children: [Text('Location', style: Boldt16)])),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(mapUrl)),
                        )
                      ]))),
              Positioned(
                  bottom: -40,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: venue.image.isEmpty
                        ? AssetImage('assets/image.png')
                        : NetworkImage(venue.image) as ImageProvider,
                  ))
            ]))));
  }
}

String staticMapUrl({
  required double latitude,
  required double longitude,
  required int width,
  required int height,
  required String apiKey,
}) {
  return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=14&size=${width}x$height&key=$apiKey';
}
