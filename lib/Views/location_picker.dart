import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../Constants/colors.dart';
import '../widgets/button.dart';

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  String? _address;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition();
    await _getAddressFromLatLng(position.latitude, position.longitude);
    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
      _mapController?.animateCamera(CameraUpdate.newLatLng(
        LatLng(position.latitude, position.longitude),
      ));
    });
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      print(placemarks);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          _address =
              '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  void _selectPlace(Prediction place) {
    double lat = double.parse(place.lat ?? '0');
    double lng = double.parse(place.lng ?? '0');
    setState(() {
      _selectedLocation = LatLng(lat, lng);
      _searchController.text = place.description ?? '';
      _address = place.description ?? '';
    });
    _mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: [
      GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _selectedLocation ?? LatLng(37.7749, -122.4194), zoom: 14),
        onTap: _onMapTapped,
        markers: _selectedLocation != null
            ? {Marker(markerId: MarkerId('selected-location'), position: _selectedLocation!)}
            : {},
      ),
      Positioned(
          top: kToolbarHeight,
          left: 10,
          right: 10,
          child: GooglePlaceAutoCompleteTextField(
              textEditingController: _searchController,
              googleAPIKey: "AIzaSyAZi4SG3M_Hut73GeIxlbkeEK1iziodxec",
              inputDecoration: InputDecoration(
                hintText: 'Search',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              debounceTime: 800,
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (prediction) {
                _selectPlace(prediction);
              },
              itemClick: (prediction) {
                _searchController.text = prediction.description ?? '';
                _address = prediction.description ?? '';
                _selectPlace(prediction);
                _searchController.selection =
                    TextSelection.fromPosition(TextPosition(offset: prediction.description?.length ?? 0));
              })),
      Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MyButton(
                  color: primary,
                  name: 'Confirm Location',
                  onPressed: () {
                    if (_selectedLocation != null) {
                      Navigator.pop(context, [_selectedLocation, _address]);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a location')));
                    }
                  })))
    ]));
  }
}
