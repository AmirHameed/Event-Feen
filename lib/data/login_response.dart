import 'dart:math';

String generateUniqueId(String name) {
  final random = Random();
  final uniqueNumber = random.nextInt(10000); // You can choose a larger range if needed
  final uniqueId = '@${name.toLowerCase()}$uniqueNumber';
  return uniqueId;
}

class LoginResponse {
  final String uuId;
  final String uniqueId;
  final String name;
  final List<String> notInterested;
  final List<String> interested;
  final String email;
  final String type;
  final String location;
  final String phoneNumber;
  final String description;
  final String image;
  final String fcmToken;

  LoginResponse(
      {required this.uuId,
      required this.uniqueId,
      required this.name,
      required this.interested,
      required this.notInterested,
      required this.email,
      required this.image,
      required this.location,
      required this.type,
      required this.phoneNumber,
      required this.description,
      required this.fcmToken});

  LoginResponse.initial(
      {required String uuId,
      required String email,
      required String name,
      required String type,
      required String location,
      required String image})
      : this(
            uuId: uuId,
            image: image,
            email: email,
            interested: [],
            notInterested: [],
            fcmToken: '',
            name: name,
            phoneNumber: '',
            description: '',
            location: location,
            type: type,
            uniqueId: generateUniqueId(name));

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final String uuid = json.containsKey('uuId') ? json['uuId'] : '';
    final String uniqueId = json.containsKey('uniqueId') ? json['uniqueId'] ?? '' : '';
    final String name = json.containsKey('name') ? json['name'] ?? '' : '';
    final String description = json.containsKey('description') ? json['description'] ?? '' : '';
    final String email = json.containsKey('email') ? json['email'] ?? '' : '';
    final String location = json.containsKey('location') ? json['location'] ?? '' : '';
    final String type = json.containsKey('type') ? json['type'] ?? '' : '';
    final String phoneNumber =
        json.containsKey('phoneNumber') ? json['phoneNumber'] ?? '(123) 345 678' : '(123) 345 678';
    final String fcmToken = json.containsKey('fcmToken') ? json['fcmToken'] ?? '' : '';
    final image = json.containsKey('image') ? json['image'] ?? '' : '';
    final List<String> interested = json.containsKey('interested')
        ? (json['interested'] as List<dynamic>?)?.map((e) => e as String).toList() ?? <String>[]
        : <String>[];
    final List<String> notInterested = json.containsKey('notInterested')
        ? (json['notInterested'] as List<dynamic>?)?.map((e) => e as String).toList() ?? <String>[]
        : <String>[];

    return LoginResponse(
        uniqueId: uniqueId,
        uuId: uuid,
        notInterested: notInterested,
        interested: interested,
        name: name,
        fcmToken: fcmToken,
        email: email,
        description: description,
        image: image,
        phoneNumber: phoneNumber,
        type: type,
        location: location);
  }

  LoginResponse copyWith(
          {String? name,
          String? description,
          String? email,
          int? balance,
          List<String>? interested,
          List<String>? notInterested,
          String? phoneNumber,
          String? fcmToken,
          String? image}) =>
      LoginResponse(
        name: name ?? this.name,
        interested: interested ?? this.interested,
        notInterested: notInterested ?? this.notInterested,
        description: description ?? this.description,
        fcmToken: fcmToken ?? this.fcmToken,
        email: email ?? this.email,
        location: location,
        type: type,
        uniqueId: uniqueId,
        image: image ?? this.image,
        uuId: uuId,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  Map<String, dynamic> toJson() => {
        'uuId': uuId,
        'name': name,
        'description': description,
        'email': email,
        'interested': interested.map((e) => e).toList(),
        'notInterested': notInterested.map((e) => e).toList(),
        'phoneNumber': phoneNumber,
        'fcmToken': fcmToken,
        'image': image,
        'location': location,
        'type': type,
        'uniqueId': uniqueId
      };

  Map<String, dynamic> toFirebaseJson() => {
        'uuId': uuId,
        'name': name,
        'email': email,
        'description': description,
        'interested': interested.map((e) => e).toList(),
        'notInterested': notInterested.map((e) => e).toList(),
        'phoneNumber': phoneNumber,
        'fcmToken': fcmToken,
        'image': image,
        'uniqueId': uniqueId,
        'location': location,
        'type': type
      };

  @override
  String toString() {
    return 'LoginResponse{ uuId: $uuId, name: $name,email: $email, phoneNumber: $phoneNumber, image: $image, fcmToken:$fcmToken, description:$description}';
  }
}
