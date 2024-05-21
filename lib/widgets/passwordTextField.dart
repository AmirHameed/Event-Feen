import 'package:flutter/material.dart';

class MyPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String title;
  MyPasswordField({this.controller, required this.title});

  @override
  _MyPasswordFieldState createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            child: Icon(
              obscureText == true ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            )),
        label: Text(widget.title),
        hintStyle: TextStyle(fontSize: 14),
      ),
    );
  }
}
