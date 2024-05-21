import 'package:flutter/material.dart';

Widget divider() {
  return Padding(
    padding: const EdgeInsets.only(left: 70),
    child: Container(
      height: 1,
      decoration: BoxDecoration(
          gradient: LinearGradient(transform: GradientRotation(1), colors: [
        Colors.white54,
        Colors.black38,
      ])),
    ),
  );
}
