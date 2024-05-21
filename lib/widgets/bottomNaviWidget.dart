import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class MyNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  const MyNavBar(
      {Key? key, required this.currentIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      backgroundColor: black,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: NavItem(
            label: 'Home',
            icon: currentIndex == 0
                ? 'assets/icons/homeActive.png'
                : 'assets/icons/home.png',
            isActive: currentIndex == 0,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: NavItem(
            label: 'Event',
            icon: 'assets/icons/calendarBar.png',
            isActive: currentIndex == 1,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
            label: '',
            icon: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: white,
                  )),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: white,
                  )),
            )),
        BottomNavigationBarItem(
          icon: NavItem(
            label: 'Alert',
            icon: currentIndex == 3
                ? 'assets/icons/notificationActive.png'
                : 'assets/icons/notificationbar.png',
            isActive: currentIndex == 3,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: NavItem(
            label: 'Profile',
            icon: currentIndex == 4
                ? 'assets/icons/profileActive.png'
                : 'assets/icons/profile.png',
            isActive: currentIndex == 4,
          ),
          label: '',
        ),
      ],
    );
  }
}

class NavItem extends StatelessWidget {
  final String label;
  final String icon;
  final bool isActive;
  const NavItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageIcon(
          AssetImage(icon),
          color: isActive
              ? white
              : Colors.white54, // Change color based on isActive status
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          label,
          style: TextStyle(
            color: isActive
                ? white
                : Colors.grey, // Change color based on isActive status
          ),
        ),
      ],
    );
  }
}
