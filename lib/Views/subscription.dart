import 'package:event_music_app/Views/select_payment_method_screen.dart';
import 'package:flutter/material.dart';
import '../Constants/colors.dart';
import '../Helper/texts.dart';
import '../widgets/button.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(
        top: 40,
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primary, black])),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                        color: white,
                      ))
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                  text: 'Get',
                  style: TextStyle(
                      fontSize: 32, color: white, fontWeight: FontWeight.w500),
                  children: <InlineSpan>[
                    TextSpan(
                      text: ' Premium',
                      style: TextStyle(
                          fontSize: 32,
                          color: blue,
                          fontWeight: FontWeight.w500),
                    ),
                  ]),
            ),
            Text('Subscription!',
                style: TextStyle(
                    fontSize: 32, color: white, fontWeight: FontWeight.w500)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Text.rich(
              TextSpan(
                  text: '\$40',
                  style: TextStyle(
                      fontSize: 40, color: white, fontWeight: FontWeight.w500),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '/mo',
                      style: TextStyle(
                          fontSize: 26,
                          color: white,
                          fontWeight: FontWeight.w300),
                    ),
                  ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: mediumWhite,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Unlimited swipes',
                        style: Regulart16,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Early access to event tickets',
                        style: Regulart16,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Exclusive content',
                        style: Regulart16,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: MyButton(
                color: primary,
                name: 'Continue',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SelectPaymentMethodScreen()));
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
