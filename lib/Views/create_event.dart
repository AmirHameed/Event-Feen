import 'package:event_music_app/Helper/firestore_database_helper.dart';
import 'package:event_music_app/data/band_model.dart';
import 'package:event_music_app/data/venue_model.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../Helper/texts.dart';

class CreateEvent extends StatefulWidget {
  CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController performerController = TextEditingController();
  final TextEditingController numberOfTicketsController = TextEditingController();

  String selectedCategory = 'Singer';

  Venue? _selectedVenue;
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  List<Venue> _venues = [];

  bool _isTimeSlotAvailable(Venue venue, DateTime date, TimeOfDay start, TimeOfDay end) {
    final selectedStart = DateTime(date.year, date.month, date.day, start.hour, start.minute);
    final selectedEnd = DateTime(date.year, date.month, date.day, end.hour, end.minute);

    for (var slot in venue.availableTimeSlots) {
      final slotStart = TimeOfDay(
        hour: int.parse(slot.startTime.split(':')[0]),
        minute: int.parse(slot.startTime.split(':')[1]),
      );
      final slotEnd = TimeOfDay(
        hour: int.parse(slot.endTime.split(':')[0]),
        minute: int.parse(slot.endTime.split(':')[1]),
      );

      final availableStart = DateTime(date.year, date.month, date.day, slotStart.hour, slotStart.minute);
      final availableEnd = DateTime(date.year, date.month, date.day, slotEnd.hour, slotEnd.minute);

      if (selectedStart.isAfter(availableStart) && selectedEnd.isBefore(availableEnd)) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    _fetchVenues();
    super.initState();
  }

  Future<void> _fetchVenues() async {
    final venues = await FirestoreDatabaseHelper.instance().getVenues();
    setState(() {
      _venues = venues!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primary, black])),
            child: Column(children: [
              SizedBox(height: 50),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Create an Event', style: t24)]),
              SizedBox(height: 10),
              Text('Event Information', style: t24),
              SizedBox(height: 10),
              Text('Event Title', style: Lightt14),
              SizedBox(height: 5),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: white), // Set the border color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Title',
                    hintStyle: Regulart16
                    // You can add more properties like prefixIcon, suffixIcon, labelText, etc.
                    ),
              ),
              SizedBox(height: 10),
              Text('Event Title', style: Lightt14),
              SizedBox(height: 5),
              TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: white), // Set the border color
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Title',
                      hintStyle: Regulart16
                      // You can add more properties like prefixIcon, suffixIcon, labelText, etc.
                      )),
              SizedBox(height: 10),
              Text(
                'Select Category',
                style: Lightt14,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      border: Border.all(color: lightWhite),
                      borderRadius: BorderRadius.circular(10)),
                  child: Expanded(
                      flex: 1,
                      child: DropdownButton<String>(
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(12),
                          underline: SizedBox(),
                          hint: Text(
                            selectedCategory,
                            style: Regulart16,
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: white,
                          ),
                          items: ['Singer', 'Music', 'other'].map((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value, style: Lightt12.copyWith(color: Colors.black)));
                          }).toList(),
                          onChanged: (String? value) {
                            if (value == null) return;
                            setState(() {
                              selectedCategory = value;
                            });
                          }))),
              SizedBox(height: 10),
              Text(
                'Performer Name',
                style: Lightt14,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: performerController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter performerName';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: white), // Set the border color
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Performer Name',
                    hintStyle: Regulart16),
              ),
              SizedBox(height: 10),
              Text(
                'Venue Location',
                style: Lightt14,
              ),
              SizedBox(
                height: 5,
              ),
              DropdownButtonFormField<Venue>(
                decoration: InputDecoration(labelText: 'Select Venue'),
                value: _selectedVenue,
                items: _venues.map((venue) {
                  return DropdownMenuItem<Venue>(
                    value: venue,
                    child: Text(venue.name),
                  );
                }).toList(),
                onChanged: (venue) {
                  setState(() {
                    _selectedVenue = venue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a venue';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Text(
                'Number of tickets available',
                style: Lightt14,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number tickets';
                  }
                  return null;
                },
                controller: numberOfTicketsController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: white), // Set the border color
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Tickets',
                    hintStyle: Regulart16),
              ),
              ElevatedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    setState(() {
                      _selectedDate = date;
                    });
                  }
                },
                child: Text(_selectedDate == null ? 'Select Date' : _selectedDate.toString()),
              ),
              ElevatedButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      _startTime = time;
                    });
                  }
                },
                child: Text(_startTime == null ? 'Select Start Time' : _startTime!.format(context)),
              ),
              ElevatedButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _startTime ?? TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      _endTime = time;
                    });
                  }
                },
                child: Text(_endTime == null ? 'Select End Time' : _endTime!.format(context)),
              ),
              SizedBox(height: 20),
              SizedBox(height: 10),
            ])));
  }
}
