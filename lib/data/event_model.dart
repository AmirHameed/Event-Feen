class Event {
  String id;
  String title;
  String performerName;
  String category;
  int numberOfTicket;
  String description;
  String location;
  String venueId;
  double lat;
  double lng;
  DateTime date;
  DateTime startTime;
  DateTime endTime;

  Event({
    required this.id,
    required this.title,
    required this.numberOfTicket,
    required this.category,
    required this.performerName,
    required this.venueId,
    required this.description,
    required this.location,
    required this.lat,
    required this.lng,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'performerName': performerName,
      'numberOfTicket':numberOfTicket,
      'category':category,
      'location': performerName,
      'lat': lat,
      'lng': lng,
      'description': performerName,
      'venueId': venueId,
      'date': date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }

  factory Event.fromMap(Map<String, dynamic> map, String documentId) {
    return Event(
      id: documentId,
      title: map['title'],
      lat: map['lat'],
      lng: map['lng'],
      category: map['category'],
      numberOfTicket:map['numberOfTicket'],
      performerName: map['performerName'],
      description: map['description'],
      location: map['location'],
      venueId: map['venueId'],
      date: DateTime.parse(map['date']),
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
    );
  }
}
