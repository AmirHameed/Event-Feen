import 'package:event_music_app/Views/add_new_card.dart';
import 'package:event_music_app/Views/venueDetail.dart';
import 'package:event_music_app/data/band_model.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../Constants/colors.dart';
import '../Helper/texts.dart';
import '../widgets/button.dart';

class ConcertDetail extends StatelessWidget {
  BandModel concern;

  ConcertDetail({super.key, required this.concern});

  final String apiKey = 'AIzaSyAZi4SG3M_Hut73GeIxlbkeEK1iziodxec';

  @override
  Widget build(BuildContext context) {
    String mapUrl = staticMapUrl(
      latitude: concern.lat,
      longitude: concern.long,
      width: 600,
      height: 300,
      apiKey: apiKey,
    );
    return Scaffold(
      backgroundColor: black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40,left: 10),
              alignment: Alignment.topLeft,
                height: 180,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: concern.image.isEmpty
                          ? AssetImage('assets/bandDetail.png')
                          : NetworkImage(concern.image) as ImageProvider,
                      fit: BoxFit.cover),
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: white,
                    ))),
            Positioned(
                top: 180,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: black,
                    boxShadow: [BoxShadow(color: black, spreadRadius: 30, blurRadius: 40)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        concern.name,
                        style: TextStyle(color: white, fontSize: 32, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/clock.png',
                            width: 20,
                            color: white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '02:12pm',
                            style: Regulart14,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Image.asset(
                          'assets/icons/calendarActive.png',
                          width: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('2 March 2024', style: Regulart14)
                      ]),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Image.asset('assets/icons/location.png', height: 20, width: 20, color: Colors.white),
                          SizedBox(width: 5),
                          Text(concern.location, style: Regulart14)
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Description',
                        style: Regulart16,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ReadMoreText(
                        concern.description,
                        trimLines: 2,
                        colorClickableText: blue,
                        style: Lightt12,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Read more',
                        trimExpandedText: 'Read less',
                        moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: blue),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(mapUrl)),
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 110),
                        child: MyButton(
                          color: primary,
                          name: 'Buy Ticket',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddNewCard()));
                          },
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
