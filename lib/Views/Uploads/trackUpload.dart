import 'package:event_music_app/widgets/button.dart';
import 'package:flutter/material.dart';

import '../../Constants/colors.dart';
import '../../Helper/texts.dart';

class TrackUpload extends StatelessWidget {
  const TrackUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/icons/dotContainer.png'),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/musicnote.png'),
                    Icon(
                      Icons.arrow_upward_rounded,
                      size: 15,
                      color: white,
                    )
                  ],
                ),
                Text.rich(
                  TextSpan(
                      text: 'Choose',
                      style: TextStyle(
                          fontSize: 16,
                          color: blue,
                          fontWeight: FontWeight.w500),
                      children: <InlineSpan>[
                        TextSpan(text: ' file to upload', style: Boldt16),
                      ]),
                ),
                Text(
                  'Select audio file',
                  style: Lightt12,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text.rich(
            TextSpan(
                text: 'Track',
                style: TextStyle(
                    fontSize: 16, color: blue, fontWeight: FontWeight.w500),
                children: <InlineSpan>[
                  TextSpan(
                    text: ' Information',
                    style: TextStyle(
                        fontSize: 16,
                        color: white,
                        fontWeight: FontWeight.w500),
                  ),
                ]),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Title',
            style: Lightt14,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: white), // Set the border color
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Title',
                hintStyle: Regulart16
                // You can add more properties like prefixIcon, suffixIcon, labelText, etc.
                ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Singers',
            style: Lightt14,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: white), // Set the border color
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter Name',
                hintStyle: Regulart16
                // You can add more properties like prefixIcon, suffixIcon, labelText, etc.
                ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Others',
            style: Lightt14,
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: white), // Set the border color
                borderRadius: BorderRadius.circular(10),
              ),

              // You can add more properties like prefixIcon, suffixIcon, labelText, etc.
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: MyButton(
              color: primary,
              name: 'Upload',
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
