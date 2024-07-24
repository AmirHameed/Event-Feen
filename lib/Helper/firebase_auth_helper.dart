import 'package:event_music_app/Helper/shared_preference_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/exception.dart';

class FirebaseAuthHelper {
  static const _WEAK_PASSWORD = 'weak-password';
  static const _WEB_CONTEXT_CANCELLED = 'web-context-cancelled';
  static const _EMAIL_ALREADY_IN_USE = 'email-already-in-use';
  static const _NETWORK_REQUEST_FAILED = 'network-request-failed';
  static const _INVALID_EMAIL = 'invalid-email';
  static const _USER_NOT_FOUND = 'user-not-found';
  static const _INVALID_CREDENTIAL = 'invalid-credential';
  static const _WRONG_PASSWORD = 'wrong-password';
  static const INVALID_VERIFICATION_CODE = 'invalid-verification-code';
  static const SESSION_EXPIRED = 'session-expired';
  static const INVALID_PHONE_NUMBER = 'invalid-phone-number';

  static FirebaseAuthHelper? _instance;

  FirebaseAuthHelper._();

  static FirebaseAuthHelper instance() {
    _instance ??= FirebaseAuthHelper._();
    return _instance!;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User> _getUser(Future<UserCredential> Function() emailPasswordClosure) async {
    try {
      return (await emailPasswordClosure.call()).user!;
    } on FirebaseAuthException catch (e) {
      print('e====>$e');
      final String errorMessage = getErrorMessage(e);
      throw CustomFirebaseAuthException(message: errorMessage);
    } catch (_) {
      throw const NoInternetConnectException();
    }
  }

  Future<User> createUserWithEmailPassword(String email, String password) =>
      _getUser(() => _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password));

  Future<User> signInWithEmailPassword(String email, String password) =>
      _getUser(() => _firebaseAuth.signInWithEmailAndPassword(email: email, password: password));

  Future<void> verifyPhoneNumber(String phone, Function(String, int?) codeSent, Function(String) autoRetrievalTimeOut,
          Function(FirebaseAuthException) firebaseAuthException) =>
      _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) {},
          timeout: const Duration(seconds: 60),
          verificationFailed: firebaseAuthException,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: autoRetrievalTimeOut);

  Future<User?> phoneSignIn(String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  String? getDatabaseErrorMessage(FirebaseException e) {
    return e.message;
  }

  String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case _USER_NOT_FOUND:
        return 'No user found with this email.';
      case _WRONG_PASSWORD:
        return 'Invalid password';
      case _INVALID_EMAIL:
        return 'Invalid email';
      case INVALID_PHONE_NUMBER:
        return 'Phone number is not valid';
      case INVALID_VERIFICATION_CODE:
        return 'You provide an invalid OTP code';
      case SESSION_EXPIRED:
        return 'Code verification session expired';
      case _WEAK_PASSWORD:
        return 'Password must be greater than 8 characters.';
      case _EMAIL_ALREADY_IN_USE:
        return 'Email is already in use try to login with different email.';
      case _NETWORK_REQUEST_FAILED:
        return 'Too many request has been made recently ';
      case _WEB_CONTEXT_CANCELLED:
        return 'The interaction was cancelled by the user.';
      case _INVALID_CREDENTIAL:
        return 'The supplied auth credential is incorrect';
      default:
        return 'Please try again after some-time.';
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await SharedPreferenceHelper.instance().clear();
  }
}
