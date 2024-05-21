import 'package:event_music_app/widgets/button.dart';
import 'package:flutter/material.dart';

import '../Constants/colors.dart';
import '../widgets/testField.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Image.asset('assets/visa.png'),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset('assets/mastercard.png'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Mytextfield(
                title: 'Card Holder Name',
              ),
              SizedBox(
                height: 20,
              ),
              Mytextfield(
                title: 'Card Holder Name',
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Mytextfield(
                      title: 'Expiry Date',
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Mytextfield(
                      title: 'CCV/CCV',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              MyButton(name: 'Pay Now', onPressed: () {}, color: primary),
              SizedBox(
                height: 10,
              ),
              Text(
                'Or',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {},
                  child: Image.asset('assets/apple-pay.png'))
            ],
          ),
        ),
      ),
    );
  }
}
