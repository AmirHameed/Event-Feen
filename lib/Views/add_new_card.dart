import 'package:event_music_app/Constants/colors.dart';
import 'package:event_music_app/Helper/texts.dart';
import 'package:event_music_app/widgets/button.dart';
import 'package:event_music_app/widgets/horizontal_credit_card_widget.dart';
import 'package:flutter/material.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  String? selectedCard = 'Master Card';

  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvNumberController = TextEditingController();

  String? cardName;
  String? cardNumber;
  String? expiryDate;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.4,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff07111B),
                      Color(0xff205081),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                            ),
                            color: Colors.white,
                          ),
                          Text(
                            'Add New Card',
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
                    HorizontalCreditCartWidget(
                      cardName: cardName,
                      cardNumber: cardNumber,
                      cardExpiryDate: expiryDate,
                      cardType: selectedCard,
                    ),
                    const Text(
                      'Card Preview',
                      style: TextStyle(color: lightWhite),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    activeColor: primary,
                    value: 'Master Card',
                    groupValue: selectedCard,
                    onChanged: (value) {
                      setState(() {
                        selectedCard = value;
                      });
                    },
                  ),
                  const Text('Master Card'),
                  const SizedBox(width: 20),
                  Radio(
                    activeColor: primary,
                    value: 'Visa Card',
                    groupValue: selectedCard,
                    onChanged: (value) {
                      setState(() {
                        selectedCard = value;
                      });
                    },
                  ),
                  const Text('Visa Card'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      label: 'Card Name',
                      hintText: 'Enter Card Name',
                      controller: cardNameController,
                      onChanged: (value) {
                        setState(() {
                          cardName = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      label: 'Card Number',
                      hintText: 'Enter Card Number',
                      controller: cardNumberController,
                      onChanged: (value) {
                        setState(() {
                          cardNumber = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: MyTextField(
                            label: 'Expiry Date',
                            hintText: 'Enter Expiry Date',
                            controller: expiryDateController,
                            onChanged: (value) {
                              setState(() {
                                expiryDate = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          flex: 2,
                          child: MyTextField(
                            label: 'CCV/CVV',
                            hintText: 'Enter CCV/CVV',
                            controller: cvvNumberController,
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 20),
                      child: MyButton(
                        color: primary,
                        name: 'Add card',
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => AddNewCard()));
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key,
      required this.label,
      required this.hintText,
      required this.controller,
      required this.onChanged});

  final String? hintText;
  final String? label;
  final TextEditingController? controller;
  final Function(String value) onChanged;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            widget.label.toString(),
            style: TextStyle(color: black),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.hintText.toString(),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: lightWhite),
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
          ),
          onChanged: (value) {
            print('Value from field $value');
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}
