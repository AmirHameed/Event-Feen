import 'dart:io';
import 'package:event_music_app/Helper/shared_preference_helper.dart';
import 'package:event_music_app/Views/location_picker.dart';
import 'package:event_music_app/data/venue_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../Constants/colors.dart';
import '../../Helper/texts.dart';
import '../Helper/dialog_helper.dart';
import '../Helper/firebase_storage_helper.dart';
import '../Helper/firestore_database_helper.dart';
import '../Helper/snackbar_helper.dart';
import '../data/material_dialog_content.dart';
import '../data/snackbar_message.dart';
import '../widgets/button.dart';

class CreateVenue extends StatefulWidget {
  CreateVenue({super.key});

  @override
  State<CreateVenue> createState() => _CreateVenueState();
}

class _CreateVenueState extends State<CreateVenue> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController facebookLinkController = TextEditingController();
  final TextEditingController googleLinkController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController facilityController = TextEditingController();
  final List<AvailableTimeSlot> _availableTimeSlots = [];
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;
  LatLng? currentLatLng;
  final List<String> _facilities = ["Parking", "WiFi", "Projector"];
  final List<String> _selectedFacilities = [];

  XFile? _profileImage;

  Future<void> _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _profileImage = pickedImage;
      }
      print('profileImage${_profileImage?.path}');
    });
  }

  Future<Object?> createVenue() async {
    try {
      final user = await SharedPreferenceHelper.instance().user;
      if (user == null) return null;
      final updatedImage =
          _profileImage == null ? '' : await FirebaseStorageHelper.instance().uploadImage(File(_profileImage!.path));

      final venue = Venue(
          id: '',
          name: nameController.text,
          description: descriptionController.text,
          googleLink: googleLinkController.text,
          facebookLink: facebookLinkController.text,
          location: locationController.text,
          latitude: currentLatLng!.latitude,
          longitude: currentLatLng!.longitude,
          image: updatedImage ?? '',
          facilities: _facilities,
          availableTimeSlots: _availableTimeSlots,
          capacity: int.parse(capacityController.text));

      await FirestoreDatabaseHelper.instance().insertVenues(venue);
      return '';
    } catch (e, s) {
      print('exception====>$e');
      print('exception====>$s');
      return null;
    }
  }

  Future<void> _createVenue(BuildContext context) async {
    final _dialogHelper = DialogHelper.instance();
    _dialogHelper
      ..injectContext(context)
      ..showProgressDialog('Creating venue...');
    final result = await createVenue();
    _dialogHelper.dismissProgress();
    if (result == null) {
      await Future.delayed(const Duration(milliseconds: 600));
      _dialogHelper
        ..injectContext(context)
        ..showTitleContentDialog(MaterialDialogContent.networkError(), () => _createVenue(context));
      return;
    }
    if (result is String && result.isNotEmpty) {
      SnackbarHelper.instance()
        ..injectContext(context)
        ..showSnackbar(
            snackbarMessage: SnackbarMessage.smallMessageError(content: result),
            margin: EdgeInsets.only(left: 25, right: 25, bottom: 90));
      return;
    }
    SnackbarHelper.instance()
      ..injectContext(context)
      ..showSnackbar(
          snackbarMessage: SnackbarMessage.smallMessage(content: 'create venue successfully'),
          margin: EdgeInsets.only(left: 25, right: 25, bottom: 90));
    await Future.delayed(const Duration(seconds: 1));
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomNavigator()));
  }

  Future<AvailableTimeSlot?> showTimeSlotPicker(BuildContext context) async {
    // Implement time slot picker logic
    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTime != null) {
      TimeOfDay? endTime = await showTimePicker(
        context: context,
        initialTime: startTime,
      );

      if (endTime != null) {
        return AvailableTimeSlot(
          startTime: startTime.format(context),
          endTime: endTime.format(context),
        );
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> image = AssetImage('assets/mainSplash.png');
    image = (_profileImage?.path == null ? AssetImage('assets/mainSplash.png') : FileImage(File(_profileImage!.path)))
        as ImageProvider<Object>;
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primary, black])),
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      SizedBox(height: 50),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Create Venue', style: t24)]),
                      SizedBox(height: 10),
                      Text('Venue Information', style: t20),
                      Container(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        SizedBox(height: 10),
                        _profileImage != null && _profileImage!.path.isNotEmpty
                            ? Container(
                                height: 120,
                                width: 250,
                                margin: EdgeInsets.symmetric(horizontal: 60),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: white,
                                    ),
                                    image: DecorationImage(image: image, fit: BoxFit.cover)))
                            : Align(
                                alignment: Alignment.center,
                                child: Container(
                                    height: 120,
                                    width: 250,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/icons/dotContainer.png'), fit: BoxFit.fill)),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () => _pickImage(),
                                      child: Column(children: [
                                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                          Image.asset('assets/icons/gallery.png'),
                                          Icon(Icons.arrow_upward_rounded, size: 15, color: white)
                                        ]),
                                        Text.rich(TextSpan(
                                            text: 'Choose',
                                            style: TextStyle(fontSize: 16, color: blue, fontWeight: FontWeight.w500),
                                            children: <InlineSpan>[
                                              TextSpan(text: ' image to upload', style: Boldt16)
                                            ])),
                                        Text('Select image file', style: Lightt12)
                                      ]),
                                    )),
                              )
                      ])),
                      SizedBox(height: 10),
                      Text('Venue Name', style: Lightt14),
                      SizedBox(height: 5),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a venue name';
                          }
                          return null;
                        },
                        style: Lightt14,
                        controller: nameController,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white12,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: lightWhite), // Set the border color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lightWhite), // Set the border color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Name',
                            hintStyle: Regulart14),
                      ),
                      SizedBox(height: 10),
                      Text('Add Social Link (Google)', style: Lightt14),
                      SizedBox(height: 5),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a google link';
                          }
                          return null;
                        },
                        style: Lightt14,
                        controller: googleLinkController,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white12,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: lightWhite), // Set the border color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lightWhite), // Set the border color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Google',
                            hintStyle: Regulart14),
                      ),
                      SizedBox(height: 10),
                      Text('Add Social Link (Facebook)', style: Lightt14),
                      SizedBox(height: 5),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a facebook link';
                          }
                          return null;
                        },
                        style: Lightt14,
                        controller: facebookLinkController,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white12,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: lightWhite), // Set the border color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lightWhite), // Set the border color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Facebook',
                            hintStyle: Regulart14),
                      ),
                      SizedBox(height: 10),
                      Text('Venue Location', style: Lightt14),
                      SizedBox(height: 5),
                      TextFormField(
                        onTap: () async {
                          final result =
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPicker()));
                          if (result != null) {
                            currentLatLng = result.first;
                            locationController.text = result.last;
                            print('Selected location: $currentLatLng, ${locationController.text}');
                          }
                        },
                        style: Lightt14,
                        controller: locationController,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select location';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            suffixIcon: Icon(CupertinoIcons.location_solid, color: white),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white12,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: lightWhite), // Set the border color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lightWhite), // Set the border color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lightWhite), // Set the border color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Location',
                            hintStyle: Regulart14
                            // You can add more properties like prefixIcon, suffixIcon, labelText, etc.
                            ),
                      ),
                      SizedBox(height: 10),
                      Text('Sitting Capacity (persons)', style: Lightt14),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: capacityController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a capacity';
                          }
                          return null;
                        },
                        style: Lightt14,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white12,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: lightWhite), // Set the border color
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: lightWhite), // Set the border color
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: lightWhite), // Set the border color
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'Capacity',
                            hintStyle: Regulart14),
                      ),
                      SizedBox(height: 10),
                      Text('Available Time Slots', style: Lightt14),
                      SizedBox(height: 5),
                      Wrap(
                          spacing: 8.0,
                          children: _availableTimeSlots.map((slot) {
                            return Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
                                child: Text('${slot.startTime} - ${slot.endTime}',
                                    style: Lightt11.copyWith(color: Colors.black)));
                          }).toList()),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 130,
                        child: MyButton(
                            fontStyle: Boldt16.copyWith(fontSize: 14),
                            color: primary,
                            name: 'Add Time Slot',
                            onPressed: () async {
                              final timeSlot = await showTimeSlotPicker(context);

                              if (timeSlot != null) {
                                setState(() {
                                  _availableTimeSlots.add(timeSlot);
                                });
                              }
                            }),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Facilities',
                        style: Lightt14,
                      ),
                      SizedBox(height: 10),
                      TextField(
                          controller: facilityController,
                          style: Lightt14,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white12,
                              hintText: 'Add a custom facility',
                              hintStyle: Regulart14,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: lightWhite), // Set the border color
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: lightWhite), // Set the border color
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: lightWhite), // Set the border color
                                  borderRadius: BorderRadius.circular(10)),
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.add_circle, color: white),
                                  onPressed: () {
                                    final newFacility = facilityController.text.trim();
                                    if (newFacility.isNotEmpty && !_facilities.contains(newFacility)) {
                                      setState(() {
                                        _facilities.add(newFacility);
                                        _selectedFacilities.add(newFacility);
                                      });
                                      facilityController.clear();
                                    }
                                  }))),
                      SizedBox(
                        height: 5,
                      ),
                      Wrap(
                          spacing: 8.0,
                          children: _facilities.map((facility) {
                            return ChoiceChip(
                                label: Text(facility,
                                    style: Lightt12.copyWith(
                                        color: _selectedFacilities.contains(facility) ? Colors.white : Colors.black)),
                                selectedColor: primary,
                                selected: _selectedFacilities.contains(facility),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedFacilities.add(facility);
                                    } else {
                                      _selectedFacilities.remove(facility);
                                    }
                                  });
                                });
                          }).toList()),
                      SizedBox(height: 10),
                      TextFormField(
                          controller: descriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                          style: Lightt14,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white12,
                              hintText: 'Description',
                              hintStyle: Regulart14,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: lightWhite), // Set the border color
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: lightWhite), // Set the border color
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: lightWhite), // Set the border color
                                  borderRadius: BorderRadius.circular(10)))),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          child: MyButton(
                              color: primary,
                              name: 'Create Venue',
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  if (_availableTimeSlots.isEmpty) {
                                    SnackbarHelper.instance()
                                      ..injectContext(context)
                                      ..showSnackbar(
                                          snackbarMessage: SnackbarMessage.smallMessageError(
                                              content: 'At least one time slot is required'),
                                          margin: EdgeInsets.only(left: 25, right: 25, bottom: 90));

                                    return;
                                  }
                                  if (_profileImage == null) {
                                    SnackbarHelper.instance()
                                      ..injectContext(context)
                                      ..showSnackbar(
                                          snackbarMessage:
                                              SnackbarMessage.smallMessageError(content: 'Venue Image is required'),
                                          margin: EdgeInsets.only(left: 25, right: 25, bottom: 90));
                                    return;
                                  }
                                  _createVenue(context);
                                }
                              }))
                    ])))));
  }
}
