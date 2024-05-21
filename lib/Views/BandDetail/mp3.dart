import 'package:event_music_app/Constants/colors.dart';
import 'package:event_music_app/Helper/texts.dart';
import 'package:event_music_app/Views/BandDetail/bandDetail.dart';
import 'package:flutter/material.dart';

class Mp3 extends StatelessWidget {
  const Mp3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomSheet: Container(
        height: 80,
        width: double.infinity,
        color: white,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  width: 200,
                  height: 5,
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset('assets/mp3.png')),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'After The Gold Rush',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 10,
                    right: 30,
                    child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          white,
                          Color.fromARGB(199, 255, 255, 255)
                        ])),
                        child: Row(
                          children: [
                            Image.asset('assets/icons/previous.png'),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.pause)),
                            Image.asset('assets/icons/next.png'),
                          ],
                        )))
              ],
            ),
          ],
        ),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemCount: 6,
          itemBuilder: (_, i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: primary),
                child: ListTile(
                  onTap: () {},
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset('assets/mp3.png')),
                  title: Text(
                    'After The Gold Rush',
                    style: Boldt16,
                  ),
                  subtitle: Text(
                    'Dolly Parton, Linda Ronstadt,Emmylou Harris',
                    maxLines: 2,
                    style: Lightt12,
                  ),
                  trailing: CircleAvatar(
                    radius: 20,
                    backgroundColor: white,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.play_arrow_rounded,
                          color: black,
                        )),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
