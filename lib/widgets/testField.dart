import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final TextEditingController? controller;
  IconData? icon;
  String? image;
  String title;
  TextInputType? type =
      "type" != null ? TextInputType.name : TextInputType.phone;
  Mytextfield({
    required this.title,
    this.type,
    this.controller,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        isDense: true,
        label: Text(title),
        hintStyle: const TextStyle(fontSize: 14),
        suffixIcon: Icon(
          icon,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }
}
