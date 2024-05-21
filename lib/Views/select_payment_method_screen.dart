import 'package:event_music_app/Constants/colors.dart';
import 'package:event_music_app/Views/add_new_card.dart';
import 'package:event_music_app/widgets/button.dart';
import 'package:flutter/material.dart';

class SelectPaymentMethodScreen extends StatelessWidget {
  const SelectPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/puzzle_card_bg.png'),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(0, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: lightWhite,
                                ),
                                child:
                                    Image.asset('assets/icons/google-pay.png'),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(0, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: lightWhite,
                                ),
                                child: Image.asset(
                                    'assets/icons/apple-pay (2).png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        child: MyButton(
                          color: primary,
                          name: 'Make Payment',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => AddNewCard()));
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Colors.white,
                        ),
                        Text(
                          'Select Payment Method',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Row(
                        children: [
                          PaymentCard(
                            image: 'assets/icons/mastercard.png',
                            userName: 'JOHN DOE',
                            cardNo: '**** **** **** 1925',
                            expiryData: '09/25',
                            cardType: 'Visa Card',
                          ),
                          PaymentCard(
                            image: 'assets/icons/visa (3).png',
                            userName: 'Andrew Cramer',
                            cardNo: '**** **** **** 1852',
                            expiryData: '02/18',
                            cardType: 'Master Card',
                          ),
                          PaymentCard(
                            image: 'assets/icons/mastercard.png',
                            userName: 'JOHN DOE',
                            cardNo: '**** **** **** 2120',
                            expiryData: '09/25',
                            cardType: 'Visa Card',
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => AddNewCard()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 90.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: white,
                        child: Icon(
                          Icons.add,
                          color: primary,
                          size: 40,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.image,
    required this.userName,
    required this.cardNo,
    required this.expiryData,
    required this.cardType,
  });
  final String? image;
  final String? userName;
  final String? expiryData;
  final String? cardNo;
  final String? cardType;

  @override
  Widget build(BuildContext context) {
    Map<String, LinearGradient> gradientsMap = {
      'Master Card': const LinearGradient(
        colors: [
          Color(0xffE42C66),
          Color(0xffF55B46),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      'Visa Card': const LinearGradient(
        colors: [
          Color(0xff9C2CF3),
          Color(0xff3A49F9),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    };
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWith * 0.4,
      height: screenHeight * 0.45,
      margin: const EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
        gradient: gradientsMap[cardType],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                userName.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(image!),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          expiryData.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          cardNo.toString(),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
