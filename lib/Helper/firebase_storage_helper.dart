import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:mime/mime.dart';

class FirebaseStorageHelper {
  static const String _IMAGES = 'images';
  static const String _VIDEOS = 'videos';
  static FirebaseStorageHelper? _instance;
  static const Duration _timeOutDuration = Duration(seconds: 50);

  final Uuid _uuid = const Uuid();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  FirebaseStorageHelper._();

  static FirebaseStorageHelper instance() {
    _instance ??= FirebaseStorageHelper._();
    return _instance!;
  }

  String get _imageId => _uuid.v4();
  String get _videosId => _uuid.v4();

  Reference get _imageUploadReference => _firebaseStorage.ref(_IMAGES);
  Reference get _videosUploadReference => _firebaseStorage.ref(_VIDEOS);

  Future<String?> uploadImage(File imageFile) async {
    try {
      final taskUpload = await _imageUploadReference.child(_imageId).putFile(imageFile).timeout(_timeOutDuration);

      print('task upload===>$taskUpload');
      return taskUpload.ref.getDownloadURL();
    } catch (e) {
      print('error====>$e');
      return null;
    }
  }
  Future<String?> uploadVideos(File imageFile) async {
    try {
      final String? contentType = lookupMimeType(imageFile.path);
      final taskUpload = await _videosUploadReference.child(_videosId).putFile(imageFile,SettableMetadata(contentType: contentType)).timeout(_timeOutDuration);
      return taskUpload.ref.getDownloadURL();
    } catch (_) {
      return null;
    }
  }
}
