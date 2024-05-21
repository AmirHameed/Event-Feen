import 'package:event_music_app/widgets/button.dart';
import 'package:flutter/material.dart';

import '../Constants/colors.dart';
import '../Views/paymentScreen.dart';

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  int _selectedRadio = 0;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedRadio = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select payment method',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: _selectedRadio,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Payment inside the stadium',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: _selectedRadio,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Online Payment',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 3,
                ),
                Image.asset('assets/icons/visa.png'),
                SizedBox(
                  width: 3,
                ),
                Image.asset('assets/icons/apple-pay.png')
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 3,
                  groupValue: _selectedRadio,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Use Wallet',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MyButton(
                name: 'Confirm Participate',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaymentScreen()));
                },
                color: primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
