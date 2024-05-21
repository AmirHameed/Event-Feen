import 'package:event_music_app/Views/Dashboard/bottomNavigation.dart';
import 'package:event_music_app/Views/signup.dart';
import 'package:event_music_app/widgets/button.dart';
import 'package:event_music_app/widgets/textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../Helper/texts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                height: 60,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/icons/small_logo.png',
                    height: 120,
                  )),
              // Align(
              //   alignment: Alignment.center,
              //   child: Text(
              //     'EVENT FEEN',
              //     style: TextStyle(
              //         fontSize: 36, fontWeight: FontWeight.bold, color: white),
              //   ),
              // ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Email',
                  style: Lightt14,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Textfield(
                prefix: 'assets/icons/email.png',
                hint: 'Email Address',
              ),
              SizedBox(
                height: 20,
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
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.6,
                        child: CupertinoSwitch(
                          value: switchButton,
                          onChanged: (v) {
                            setState(() {
                              switchButton = v;
                            });
                          },
                          activeColor: blue,
                          trackColor: Colors.grey,
                        ),
                      ),
                      Text(
                        'Remember Me',
                        style: TextStyle(
                          fontSize: 12,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Forget Password?',
                    style: TextStyle(
                        fontSize: 12,
                        color: white,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
              SizedBox(
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: MyButton(
                  color: primary,
                  name: 'Login',
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomNavigator()));
                  },
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?  ",
                    style: TextStyle(
                      fontSize: 12,
                      color: white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUp(
                                    type: 'feen',
                                  )));
                    },
                    child: Text(
                      'Feen',
                      style: TextStyle(
                          fontSize: 14,
                          color: blue,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      thickness: 1,
                      color: white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUp(
                                    type: 'bands',
                                  )));
                    },
                    child: Text(
                      'Bands',
                      style: TextStyle(
                          fontSize: 14,
                          color: blue,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      thickness: 1,
                      color: white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUp(
                                    type: 'venues',
                                  )));
                    },
                    child: Text(
                      'Venues',
                      style: TextStyle(
                          fontSize: 14,
                          color: blue,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
