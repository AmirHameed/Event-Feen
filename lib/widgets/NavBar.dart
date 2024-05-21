import 'package:flutter/material.dart';

class BottomNavigationBarHandler {
  Widget bar(int currentIndex) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.white, width: 3.0))),
        child: BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.pinkAccent,
            unselectedItemColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: onTabTapped,
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Match'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Shop'),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Profile')
            ]));
  }

  void onTabTapped(int index) {
    print('BottomNavigationBarIndex ::' + index.toString());
  }
}
