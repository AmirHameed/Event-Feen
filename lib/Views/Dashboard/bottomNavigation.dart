import 'package:event_music_app/Views/notification.dart';
import 'package:event_music_app/Views/paymentScreen.dart';
import 'package:flutter/material.dart';

import '../../Constants/colors.dart';
import '../../widgets/bottomNaviWidget.dart';
import '../UpComingEvents.dart';
import '../dashboard.dart';
import '../profile.dart';
import '../Uploads/upload.dart';

class CustomNavigator extends StatefulWidget {
  const CustomNavigator({super.key});

  @override
  State<CustomNavigator> createState() => _CustomNavigatorState();
}

List<Widget> widgets = [
  HomePage(),
  UpComingEvents(),
  Uploads(),
  Notifications(),
  Profile()
];

class _CustomNavigatorState extends State<CustomNavigator> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MyNavBar(
          currentIndex: _currentIndex,
          onTabTapped: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 100),
                curve: Curves.ease,
              );
            });
          },
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: widgets,
        ));
  }
}
