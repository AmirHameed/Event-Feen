import 'package:event_music_app/Views/add_new_card.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../Constants/colors.dart';
import '../Helper/texts.dart';
import '../widgets/button.dart';

class ConcertDetail extends StatelessWidget {
  const ConcertDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/bandDetail.png',
                ),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: white,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: height(context) * 0.25,
              ),
              Text(
                'Rock Concert',
                style: TextStyle(
                    color: white, fontSize: 32, fontWeight: FontWeight.w500),
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
              Row(
                children: [
                  Image.asset(
                    'assets/icons/calendarActive.png',
                    width: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '2 March 2024',
                    style: Regulart14,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
                trimLines: 2,
                colorClickableText: blue,
                style: Lightt12,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Read more',
                trimExpandedText: 'Read less',
                moreStyle: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: blue),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset('assets/map.png'),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 110),
                child: MyButton(
                  color: primary,
                  name: 'Buy Ticket',
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => AddNewCard()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
