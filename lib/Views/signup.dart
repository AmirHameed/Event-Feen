import 'package:event_music_app/Views/Dashboard/bottomNavigation.dart';
import 'package:event_music_app/Views/loginScreen.dart';
import 'package:event_music_app/widgets/button.dart';
import 'package:event_music_app/widgets/textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../Helper/texts.dart';

class SignUp extends StatefulWidget {
  final String? type;
  SignUp({super.key, this.type});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool switchButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primary, black])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.type == 'feen'
                      ? 'Feen'
                      : widget.type == 'bands'
                          ? 'Bands'
                          : 'Venues',
                  style: t24,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 60),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: white,
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/gallery.png'),
                        Icon(
                          Icons.arrow_upward_rounded,
                          size: 15,
                          color: white,
                        ),
                      ],
                    ),
                    Text(
                      'Add Photos',
                      style: Lightt12,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.type == 'feen'
                      ? 'Username'
                      : widget.type == 'bands'
                          ? 'Band Name'
                          : 'Venue Name',
                  style: Lightt14,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Textfield(
                prefix: 'assets/icons/email.png',
                hint: widget.type == 'feen'
                    ? 'Username'
                    : widget.type == 'bands'
                        ? 'Band Name'
                        : 'Venue Name',
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.type == 'venues' ? 'Location' : 'Email',
                  style: Lightt14,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Textfield(
                prefix: 'assets/icons/email.png',
                hint: widget.type == 'venues' ? 'Location' : 'Email',
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Password',
                  style: Lightt14,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Textfield(
                prefix: 'assets/icons/keyPassword.png',
                suffix: Icons.remove_red_eye_outlined,
                hint: 'Password',
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Confirm Password',
                  style: Lightt14,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Textfield(
                prefix: 'assets/icons/keyPassword.png',
                suffix: Icons.remove_red_eye_outlined,
                hint: 'Confirm Password',
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: MyButton(
                  color: primary,
                  name: 'SignUp',
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomNavigator()));
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 12,
                        color: white,
                      ),
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 12,
                          color: blue,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
