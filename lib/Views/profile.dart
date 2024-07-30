import 'package:event_music_app/Helper/firebase_auth_helper.dart';
import 'package:event_music_app/Views/AdsUpload.dart';
import 'package:event_music_app/Views/create_venue.dart';
import 'package:event_music_app/Views/loginScreen.dart';
import 'package:event_music_app/Views/myInterest.dart';
import 'package:event_music_app/Views/settings.dart';
import 'package:event_music_app/Views/subscription.dart';
import 'package:flutter/material.dart';
import '../Constants/colors.dart';
import '../Helper/shared_preference_helper.dart';
import '../Helper/texts.dart';
import '../data/login_response.dart';
import '../widgets/divider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  LoginResponse? user;

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  Future<void> getProfile() async {
    user = await SharedPreferenceHelper.instance().user;
    setState(() {});
  }

  signOut() async {
    await FirebaseAuthHelper.instance().signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: user == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.only(top: 40),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primary, black])),
                child: SingleChildScrollView(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'PROFILE',
                          style: TextStyle(color: white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Image.asset(
                          'assets/icons/edit.png',
                          color: white,
                          width: 25,
                          height: 25,
                        )
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    user!.name,
                    style: t20,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    user!.uniqueId,
                    style: Lightt14,
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                    child: Text(
                      user!.description,
                      textAlign: TextAlign.center,
                      style: Regulart14,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Subscription()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: EdgeInsets.only(left: 5, top: 5, bottom: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mediumWhite,
                      ),
                      child: ListTile(
                          leading: Image.asset(
                            'assets/icons/subscription.png',
                            color: white,
                          ),
                          title: Text('Get Subscription', style: Regulart16),
                          subtitle: Text('Upgrade your subscription plan', style: Lightt11)),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateVenue()));
                    },
                    leading: Image.asset(
                      'assets/icons/profile.png',
                    ),
                    title: Text('My Account', style: Regulart16),
                  ),
                  divider(),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyInterest()));
                    },
                    leading: Image.asset(
                      'assets/icons/heart.png',
                    ),
                    title: Text('My Favorite', style: Regulart16),
                  ),
                  divider(),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => AdsUpload()));
                    },
                    leading: Image.asset('assets/icons/ad.png'),
                    title: Text('Ad Centre', style: Regulart16),
                  ),
                  divider(),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/refresh.png',
                    ),
                    title: Text('Subscription History', style: Regulart16),
                  ),
                  divider(),
                  ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => Settings()));
                      },
                      leading: Image.asset('assets/icons/setting-2.png'),
                      title: Text('Settings', style: Regulart16)),
                  divider(),
                  ListTile(
                      onTap: () => signOut(),
                      leading: Image.asset('assets/icons/logout.png'),
                      title: Text('Sign Out', style: TextStyle(color: red, fontSize: 16, fontWeight: FontWeight.w400)))
                ]))));
  }
}
