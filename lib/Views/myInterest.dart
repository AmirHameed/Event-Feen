import 'package:event_music_app/Views/BandDetail/bandDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constants/colors.dart';
import '../Helper/texts.dart';
import '../widgets/divider.dart';
import '../widgets/switchbutton.dart';

class MyInterest extends StatefulWidget {
  const MyInterest({super.key});

  @override
  State<MyInterest> createState() => _MyInterestState();
}

class _MyInterestState extends State<MyInterest> {
  bool switchButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
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
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: white,
                        )),
                  ),
                ),
              ),
              Expanded(
                flex: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/heart.png',
                          color: white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'My Interest',
                          style: t24,
                        ),
                      ],
                    ),
                    Text(
                      'Your favourite brand',
                      style: Lightt14,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => BandDetails()));
            },
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/bands.png'),
            ),
            title: Text(
              'Band Name',
              style: Regulart16,
            ),
            subtitle: Text(
              '@band_id',
              style: Lightt12,
            ),
          ),
          divider(),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/bands.png'),
            ),
            title: Text(
              'Band Name',
              style: Regulart16,
            ),
            subtitle: Text(
              '@band_id',
              style: Lightt12,
            ),
          ),
          divider(),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/bands.png'),
            ),
            title: Text(
              'Band Name',
              style: Regulart16,
            ),
            subtitle: Text(
              '@band_id',
              style: Lightt12,
            ),
          ),
          divider(),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/bands.png'),
            ),
            title: Text(
              'Band Name',
              style: Regulart16,
            ),
            subtitle: Text(
              '@band_id',
              style: Lightt12,
            ),
          ),
          divider(),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/bands.png'),
            ),
            title: Text(
              'Band Name',
              style: Regulart16,
            ),
            subtitle: Text(
              '@band_id',
              style: Lightt12,
            ),
          ),
          divider(),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/bands.png'),
            ),
            title: Text(
              'Band Name',
              style: Regulart16,
            ),
            subtitle: Text(
              '@band_id',
              style: Lightt12,
            ),
          ),
          SizedBox(
            height: 120,
          )
        ],
      ),
    ));
  }
}
