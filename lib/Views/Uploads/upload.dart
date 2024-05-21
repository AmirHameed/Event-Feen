import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../Helper/texts.dart';
import 'VideosUpload.dart';
import 'trackUpload.dart';

class Uploads extends StatefulWidget {
  const Uploads({super.key});

  @override
  State<Uploads> createState() => _UploadsState();
}

class _UploadsState extends State<Uploads> {
  bool switchButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primary, black])),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: 50,
                // ),
                Row(
                  children: [
                    Text(
                      'Upload',
                      style: t24,
                    ),
                  ],
                ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: IconButton(
                //       onPressed: () {},
                //       icon: Icon(
                //         Icons.close,
                //         color: white,
                //       )),
                // ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _tabSection(context),
          ],
        ),
      ),
    ));
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    surfaceVariant: Colors.transparent,
                  ),
            ),
            child: TabBar(
                indicatorColor: blue,
                dividerColor: Colors.transparent,
                unselectedLabelColor: lightWhite,
                labelColor: white,
                automaticIndicatorColorAdjustment: false,
                tabs: [
                  Text('Tracks'),
                  Text('Music Videos'),
                  Text('Photos'),
                ]),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: TabBarView(children: [
              TrackUpload(),
              VideosUpload(),
              Container(
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
                                image:
                                    AssetImage('assets/icons/dotContainer.png'),
                                fit: BoxFit.fill)),
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
                                    TextSpan(
                                        text: ' file to upload',
                                        style: Boldt16),
                                  ]),
                            ),
                            Text(
                              'Select video file',
                              style: Lightt12,
                            )
                          ],
                        ),
                      ),
                    ]),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
