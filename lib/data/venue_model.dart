class Venue {
  final String id;
  final String name;
  final String description;
  final String location;
  final double latitude;
  final double longitude;
  final String googleLink;
  final String facebookLink;
  final String image;
  final List<String> facilities;
  final List<AvailableTimeSlot> availableTimeSlots;
  final int capacity;

  Venue({
    required this.id,
    required this.name,
    required this.description,
    required this.googleLink,
    required this.facebookLink,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.image,
    required this.facilities,
    required this.availableTimeSlots,
    required this.capacity,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'image': image,
      'facilities': facilities.map((e)=>e).toList(),
      'availableTimeSlots': availableTimeSlots.map((slot) => slot.toMap()).toList(),
      'capacity': capacity,
    };
  }

  factory Venue.fromMap(Map<String, dynamic> map, String documentId) {
    final String name = map.containsKey('name') ? map['name'] ?? '' : '';
    final String googleLink = map.containsKey('googleLink') ? map['googleLink'] ?? '' : '';
    final String facebookLink = map.containsKey('facebookLink') ? map['facebookLink'] ?? '' : '';
    final String location = map.containsKey('location') ? map['location'] ?? '' : '';
    final String description = map.containsKey('description') ? map['description'] ?? '' : '';
    final String image = map.containsKey('image') ? map['image'] ?? '' : '';
    final double latitude = map.containsKey('latitude') ? map['latitude'] ?? 0.0 : 0.0;
    final double longitude = map.containsKey('longitude') ? map['longitude'] ?? 0.0 : 0.0;
    final int capacity = map.containsKey('capacity') ? map['capacity'] ?? 0 : 0;

    return Venue(
      id: documentId,
      name: name,
      description: description,
      googleLink: googleLink,
      facebookLink: facebookLink,
      location: location,
      latitude: latitude,
      longitude: longitude,
      image: image,
      facilities: List<String>.from(map['facilities']),
      availableTimeSlots: (map['availableTimeSlots'] as List).map((slot) => AvailableTimeSlot.fromMap(slot)).toList(),
      capacity: capacity,
    );
  }
}

class AvailableTimeSlot {
  String startTime;
  String endTime;

  AvailableTimeSlot({required this.startTime, required this.endTime});

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory AvailableTimeSlot.fromMap(Map<String, dynamic> map) {
    return AvailableTimeSlot(
      startTime: map['startTime'],
      endTime: map['endTime'],
    );
  }
}
