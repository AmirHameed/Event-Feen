import 'package:event_music_app/widgets/button.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../Helper/texts.dart';

class AdsUpload extends StatelessWidget {
  AdsUpload({super.key});
  String _value = 'Georgia';
  List<String> location = [
    'Alabama'
        'Alaska'
        'Arizona'
        'Arkansas'
        'California'
        'Colorado'
        'Connecticut'
        'Delaware'
        'Florida'
        'Georgia'
        'Hawaii'
        'Idaho'
        'Illinois'
        'Indiana'
        'Iowa'
        'Kansas'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primary, black])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: white,
                        )),
                  ),
                  Row(
                    children: [
                      Image.asset('assets/icons/ad.png'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Ad Centre',
                        style: t20,
                      ),
                    ],
                  ),
                  SizedBox()
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: white,
                      )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/gallery.png'),
                          Icon(
                            Icons.arrow_upward_rounded,
                            size: 15,
                            color: white,
                          ),
                        ],
                      ),
                      Text(
                        'Add Photos',
                        style: Lightt12,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: white,
                      )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/videoUpload.png'),
                        ],
                      ),
                      Text(
                        'Add Video',
                        style: Lightt12,
                      )
                    ],
                  ),
                )
              ],
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
                    borderSide:
                        BorderSide(color: white), // Set the border color
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
              'Description',
              style: Lightt14,
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              maxLines: 6,
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white12,
                  border: Border.all(color: Colors.white30)),
              child: Row(
                children: [
                  Image.asset('assets/icons/location.png'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'City',
                    style: TextStyle(
                        color: white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      thickness: 1,
                      color: white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text(
                        'Los Angeles',
                        style: Lightt12,
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: white,
                      ),
                      items: location.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: Lightt12,
                          ),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: MyButton(
                color: primary,
                name: 'Run Ad',
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
