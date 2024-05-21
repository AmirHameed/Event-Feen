import 'package:event_music_app/Constants/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Textfield extends StatelessWidget {
  Textfield(
      {this.text,
      this.label,
      this.prefix,
      this.readOnly,
      this.hint,
      this.help,
      this.hintColor,
      this.isPassword,
      this.suffix});
  TextEditingController? text;
  final String? label;
  final String? prefix;
  final IconData? suffix;
  final String? hint;
  final String? help;
  final bool? isPassword;
  final bool? readOnly;
  final Color? hintColor;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: text,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: white), // Set the border color
          borderRadius: BorderRadius.circular(25),
        ),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
        prefixIcon: Image.asset(prefix!),
        suffixIcon: suffix == null ? null : Icon(suffix!),
      ),
    );
  }
}
