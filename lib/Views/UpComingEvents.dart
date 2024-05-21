import 'dart:math';

import 'package:event_music_app/Helper/texts.dart';
import 'package:event_music_app/Views/concertDetail.dart';
import 'package:event_music_app/Views/venueDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/colors.dart';

class UpComingEvents extends StatefulWidget {
  const UpComingEvents({super.key});

  @override
  State<UpComingEvents> createState() => _UpComingEventsState();
}

String _value = 'Georgia';
List<String> location = [
  'Alabama'
      'Alaska'
      'Arizona'
      'Arkansas'
      'California'
      'Colorado'
      'Connecticut'
      'Delaware'
      'Florida'
      'Georgia'
      'Hawaii'
      'Idaho'
      'Illinois'
      'Indiana'
      'Iowa'
      'Kansas'
];
bool switchButton = false;

class _UpComingEventsState extends State<UpComingEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(
        top: 40,
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primary, black])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  switchButton ? 'VENUES' : 'UPCOMING EVENTS',
                  style: TextStyle(
                      color: white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Text(switchButton ? 'Switch to Events' : 'Switch to Venues',
                        style: Lightt11),
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        value: switchButton,
                        onChanged: (v) {
                          setState(() {
                            switchButton = v;
                          });
                        },
                        activeColor: blue,
                        trackColor: white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
            decoration: BoxDecoration(
              color: bg,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      switchButton ? 'Los Angeles' : 'This Week',
                      style: TextStyle(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: white,
                    )
                  ],
                ),
                switchButton
                    ? Row(
                        children: [
                          Text(
                            'Search',
                            style: TextStyle(
                                color: white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.search,
                            color: white,
                          )
                        ],
                      )
                    : InkWell(
                        onTap: () {},
                        child: Text(
                          'Monday, March 18, 2024',
                          style: TextStyle(
                              color: white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Row(
                  children: [
                    Image.asset('assets/icons/filter.png'),
                    Text(
                      'by',
                      style: TextStyle(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 20,
                  child: VerticalDivider(
                    thickness: 1,
                    color: white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: white,
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                if (!switchButton)
                  Container(
                    width: 80,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text(
                        'Location',
                        style: Lightt12,
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: white,
                      ),
                      items: location.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: black,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 80,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: SizedBox(),
                    hint: Text(
                      'Genre',
                      style: Lightt12,
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: white,
                    ),
                    items: location.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: black,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: white,
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: 4,
                itemBuilder: (c, i) {
                  return switchButton
                      ? Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ListTile(
                                leading: Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Rock Concert',
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                  child: Divider(
                                                    color: Colors.primaries[
                                                        Random().nextInt(Colors
                                                            .primaries.length)],
                                                    thickness: 3,
                                                    indent: 4,
                                                    endIndent: 4,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: bg,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) => switchButton
                                                            ? VenueDetail()
                                                            : ConcertDetail()));
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward,
                                                color: white,
                                              )),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                            'assets/icons/location.png'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Warren, OH Packard Music Hall',
                                          style: TextStyle(
                                              color: white, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Divider(
                                  thickness: 1,
                                  color: lightWhite,
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ListTile(
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'March',
                                      style:
                                          TextStyle(color: white, fontSize: 14),
                                    ),
                                    Text(
                                      '18',
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              child: VerticalDivider(
                                                color: Colors.primaries[Random()
                                                    .nextInt(Colors
                                                        .primaries.length)],
                                                thickness: 3,
                                                indent: 4,
                                                endIndent: 4,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Monday',
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    CircleAvatar(
                                                      radius: 3,
                                                      backgroundColor: white,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '03:45pm',
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Rock Concert',
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: bg,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            ConcertDetail()));
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward,
                                                color: white,
                                              )),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                            'assets/icons/location.png'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Warren, OH Packard Music Hall',
                                          style: TextStyle(
                                              color: white, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Divider(
                                  thickness: 1,
                                  color: lightWhite,
                                ),
                              )
                            ],
                          ),
                        );
                }),
          ),
        ],
      ),
    ));
  }
}
