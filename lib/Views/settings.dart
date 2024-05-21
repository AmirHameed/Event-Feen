import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/colors.dart';
import '../Helper/texts.dart';
import '../widgets/button.dart';
import '../widgets/divider.dart';
import '../widgets/switchbutton.dart';
import 'dashboard.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switchButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
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
                flex: 2,
                child: Align(
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
              ),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/setting-2.png',
                      color: white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Settings',
                      style: t24,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Image.asset(
              'assets/icons/notification.png',
              color: white,
            ),
            title: Text(
              'Notification',
              style: Regulart16,
            ),
            trailing: CupertinoSwitch(
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
          divider(),
          ListTile(
              leading: Image.asset(
                'assets/icons/sun.png',
                color: white,
              ),
              title: Text(
                'Theme Mode',
                style: Regulart16,
              ),
              trailing: SwitchIcon(
                sun: 'assets/icons/sun.png',
                moon: 'assets/icons/moon.png',
              )),
          divider(),
          ListTile(
            leading: Image.asset(
              'assets/icons/language-outline.png',
              color: white,
            ),
            title: Text(
              'Language',
              style: Regulart16,
            ),
          ),
          divider(),
          ListTile(
            leading: Image.asset(
              'assets/icons/information.png',
              color: white,
            ),
            title: Text(
              'Terms and Conditions',
              style: Regulart16,
            ),
          ),
          divider(),
          ListTile(
            leading: Image.asset(
              'assets/icons/help-outline.png',
              color: white,
            ),
            title: Text(
              'Help',
              style: Regulart16,
            ),
          ),
          divider(),
          ListTile(
            leading: Image.asset(
              'assets/icons/share.png',
              color: white,
            ),
            title: Text(
              'Share Event Feen',
              style: Regulart16,
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
