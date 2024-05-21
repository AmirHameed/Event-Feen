import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class SwitchIcon extends StatefulWidget {
  final String sun;
  final String moon;

  SwitchIcon({required this.sun, required this.moon});

  @override
  _SwitchIconState createState() => _SwitchIconState();
}

class _SwitchIconState extends State<SwitchIcon> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _switchValue = !_switchValue;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CupertinoSwitch(
            value: _switchValue,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
              });
            },
            activeColor: black,
            trackColor: white,
          ),
          Positioned(
            left: 10,
            child: Image.asset(
              widget.sun,
              width: 15,
              color: _switchValue ? Colors.white : Colors.white,
            ),
          ),
          Positioned(
            right: 10,
            child: Image.asset(
              widget.moon,
              color: _switchValue ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
