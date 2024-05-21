import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/colors.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(
        top: 50,
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
            padding: EdgeInsets.only(left: 25),
            child: Text(
              'ALERTS',
              style: TextStyle(
                  color: white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: bg,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/icons/s_map.png'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Nearby bands',
                      style: TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: white,
                      size: 16,
                    ))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: 4,
                itemBuilder: (c, i) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: white,
                              radius: 30,
                            ),
                            title: Text(
                              'Dennis Nedry shows interest  in your band',
                              style: TextStyle(color: white, fontSize: 14),
                            ),
                            subtitle: Text(
                              '2 hours ago',
                              style: TextStyle(color: lightWhite, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }
}
