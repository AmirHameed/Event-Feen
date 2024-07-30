import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class BandModel {
  final String uuId;
  final String name;
  final DateTime dateTime;
  final String profileId;
  final String description;
  final String image;
  final String location;
  final double lat;
  final double long;
  final List<String> genre;
  final int totalMember;
  final String googleLink;
  final String facebookLink;
  final double totalRating;
  final List<Review> reviews;
  final List<String> photos;
  final List<Track> tracks;
  final List<Video> videos;
  final GeoPoint geoPoint;

  BandModel(
      {required this.uuId,
      required this.name,
      required this.location,
      required this.dateTime,
      required this.lat,
      required this.long,
      required this.profileId,
      required this.description,
      required this.image,
      required this.genre,
      required this.totalMember,
      required this.googleLink,
      required this.facebookLink,
      required this.totalRating,
      required this.reviews,
      required this.photos,
        required this.geoPoint,
      required this.tracks,
      required this.videos});

  BandModel.initial(
      {required String name,
      required String description,
      required String image,
      required String profileId,
        required GeoPoint geoPoint,
        required String location,
      required List<String> genre,
      required String googleLink,
      required String facebookLink})
      : this(
            uuId: '',
            name: name,
            location: location,
            description: description,
            image: image,
            profileId: profileId,
            lat: 0.0,
            long: 0.0,
            genre: genre,
            geoPoint: geoPoint,
            dateTime: DateTime.now(),
            googleLink: googleLink,
            facebookLink: facebookLink,
            tracks: [],
            photos: [],
            reviews: [],
            videos: [],
            totalRating: 0.0,
            totalMember: 0);

  BandModel copyWith(
          {List<Video>? videos,
          List<Track>? tracks,
          List<String>? photos,
          List<Review>? reviews,
          double? totalRating,
          DateTime? dateTime,
          double? lat,
          double? long,
          String? location,
          int? totalMember}) =>
      BandModel(
          uuId: uuId,
          name: name,
          lat: lat ?? this.lat,
          long: long ?? this.long,
          dateTime: dateTime ?? this.dateTime,
          description: description,
          image: image,
          geoPoint: geoPoint,
          location: location ?? this.location,
          profileId: profileId,
          genre: genre,
          totalMember: totalMember ?? this.totalMember,
          googleLink: googleLink,
          facebookLink: facebookLink,
          totalRating: totalRating ?? this.totalRating,
          reviews: reviews ?? this.reviews,
          photos: photos ?? this.photos,
          tracks: tracks ?? this.tracks,
          videos: videos ?? this.videos);

  factory BandModel.fromJson(Map<String, dynamic> json, String id) {
    final String location = json.containsKey('location') ? json['location'] ?? '' : '';
    final String name = json.containsKey('name') ? json['name'] ?? '' : '';
    final GeoPoint geoPoint = json.containsKey('geoPoint') ? json['geoPoint'] ?? GeoPoint(0.0, 0.0) : GeoPoint(0.0, 0.0);
    final String profileId = json.containsKey('profileId') ? json['profileId'] ?? '' : '';
    final String description = json.containsKey('description') ? json['description'] ?? '' : '';
    final image = json.containsKey('image') ? json['image'] ?? '' : '';
    final List<String> genre = json.containsKey('genre')
        ? (json['genre'] as List<dynamic>?)?.map((e) => e as String).toList() ?? <String>[]
        : <String>[];
    final int totalMember = json.containsKey('totalMember') ? json['totalMember'] ?? 0 : 0;
    final double lat = json.containsKey('lat') ? json['lat'] ?? 0.0 : 0.0;
    final double long = json.containsKey('long') ? json['long'] ?? 0.0 : 0.0;

    final String googleLink = json.containsKey('googleLink') ? json['googleLink'] ?? '' : '';
    final String facebookLink = json.containsKey('facebookLink') ? json['facebookLink'] ?? '' : '';

    final double totalRating = json.containsKey('totalRating') ? json['totalRating'] ?? 0.0 : 0.0;

    final String timestamp = json.containsKey('dateTime') ? json['dateTime'] ?? '' : '';

    print('timeStamp $timestamp');

    final DateTime dateTime = timestamp.isEmpty ? DateTime.now() : DateTime.parse(timestamp);
    final reviewSerialization = json.containsKey('reviews') ? json['reviews'] : null;
    final reviews = reviewSerialization == null
        ? <Review>[]
        : (reviewSerialization as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .map((e) => Review.fromJson(e))
            .toList();

    final List<String> photos = json.containsKey('photos')
        ? (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ?? <String>[]
        : <String>[];

    final trackSerialization = json.containsKey('tracks') ? json['tracks'] : null;
    final tracks = trackSerialization == null
        ? <Track>[]
        : (trackSerialization as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .map((e) => Track.fromJson(e))
            .toList();

    final videoSerialization = json.containsKey('videos') ? json['videos'] : null;

    final videos = videoSerialization == null
        ? <Video>[]
        : (videoSerialization as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .map((e) => Video.fromJson(e))
            .toList();

    return BandModel(
        uuId: id,
        geoPoint: geoPoint,
        name: name,
        dateTime: dateTime,
        lat: lat,
        long: long,
        location: location,
        profileId: profileId,
        description: description,
        image: image,
        genre: genre,
        totalMember: totalMember,
        googleLink: googleLink,
        facebookLink: facebookLink,
        totalRating: totalRating,
        reviews: reviews,
        photos: photos,
        tracks: tracks,
        videos: videos);
  }

  Map<String, dynamic> toJson() => {
        'uuId': uuId,
        'name': name,
        'lat': lat,
        'long': long,
        'dateTime': dateTime.toString(),
        'location': location,
        'geoPoint': geoPoint,
        'profileId': profileId,
        'description': description,
        'image': image,
        'genre': genre.map((e) => e).toList(),
        'totalMember': totalMember,
        'googleLink': googleLink,
        'facebookLink': facebookLink,
        'totalRating': totalRating,
        'reviews': reviews.map((e) => e.toJson()).toList(),
        'photos': photos.map((e) => e).toList(),
        'tracks': tracks.map((e) => e.toJson()).toList(),
        'videos': videos.map((e) => e.toJson()).toList()
      };
}

class Review {
  final String uuId;
  final String name;
  final String profileId;
  final String image;
  final String description;
  final DateTime dateTime;

  Review(
      {required this.uuId,
      required this.name,
      required this.description,
      required this.dateTime,
      required this.image,
      required this.profileId});

  factory Review.fromJson(Map<String, dynamic> json) {
    final String uuid = json.containsKey('uuId') ? json['uuId'] : '';
    final String profileId = json.containsKey('profileId') ? json['profileId'] : '';
    final String description = json.containsKey('description') ? json['description'] ?? '' : '';
    final String name = json.containsKey('name') ? json['name'] ?? '' : '';
    final String timestamp = json.containsKey('dateTime') ? json['dateTime'] ?? '' : '';
    final DateTime dateTime = DateTime.parse(timestamp);
    final image = json.containsKey('image') ? json['image'] ?? '' : '';

    return Review(
        uuId: uuid, name: name, image: image, description: description, dateTime: dateTime, profileId: profileId);
  }

  Map<String, dynamic> toJson() => {
        'uuId': uuId,
        'name': name,
        'description': description,
        'image': image,
        'dateTime': dateTime,
        'profileId': profileId
      };
}

class Track {
  final String uuId;
  final String title;
  final String image;
  final String file;
  final String singers;
  final String other;

  Track(
      {required this.uuId,
      required this.title,
      required this.file,
      required this.singers,
      required this.image,
      required this.other});

  factory Track.fromJson(Map<String, dynamic> json) {
    final String uuid = json.containsKey('uuId') ? json['uuId'] : '';
    final String title = json.containsKey('title') ? json['title'] ?? '' : '';
    final String file = json.containsKey('file') ? json['file'] ?? '' : '';
    final String other = json.containsKey('other') ? json['other'] ?? '' : '';
    final String singers = json.containsKey('singers') ? json['singers'] ?? '' : '';
    final image = json.containsKey('image') ? json['image'] ?? '' : '';

    return Track(uuId: uuid, title: title, image: image, file: file, other: other, singers: singers);
  }

  Map<String, dynamic> toJson() =>
      {'uuId': uuId, 'title': title, 'file': file, 'singers': singers, 'image': image, 'other': other};
}

class Video {
  final String uuId;
  final String title;
  final String image;
  final String file;
  final String description;

  Video({required this.uuId, required this.title, required this.file, required this.description, required this.image});

  factory Video.fromJson(Map<String, dynamic> json) {
    final String uuid = json.containsKey('uuId') ? json['uuId'] : '';
    final String title = json.containsKey('title') ? json['title'] ?? '' : '';
    final String file = json.containsKey('file') ? json['file'] ?? '' : '';
    final String description = json.containsKey('description') ? json['description'] ?? '' : '';
    final image = json.containsKey('image') ? json['image'] ?? '' : '';

    return Video(uuId: uuid, title: title, image: image, file: file, description: description);
  }

  Map<String, dynamic> toJson() =>
      {'uuId': uuId, 'title': title, 'file': file, 'description': description, 'image': image};
}
