import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_music_app/Views/Dashboard/bottomNavigation.dart';
import 'package:event_music_app/Views/loginScreen.dart';
import 'package:event_music_app/translation/locale_keys.g.dart';
import 'package:event_music_app/widgets/button.dart';
import 'package:event_music_app/widgets/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../Helper/texts.dart';
import '../Helper/dialog_helper.dart';
import '../Helper/firebase_auth_helper.dart';
import '../Helper/firebase_storage_helper.dart';
import '../Helper/firestore_database_helper.dart';
import '../Helper/shared_preference_helper.dart';
import '../Helper/snackbar_helper.dart';
import '../data/exception.dart';
import '../data/login_response.dart';
import '../data/material_dialog_content.dart';
import '../data/snackbar_message.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  final String? type;

  SignUp({super.key, this.type});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Future<Object?> signUp() async {
    try {
      final User user = await FirebaseAuthHelper.instance().createUserWithEmailPassword(email.text, password.text);
      if (user.email == null) return null;
      final updatedImage =
      _profileImage == null ? '' : await FirebaseStorageHelper.instance().uploadImage(File(_profileImage!.path));
      final initialUser = LoginResponse.initial(
          uuId: user.uid,
          email: user.email ?? '',
          name: name.text,
          location: location.text,
          type: widget.type!,
          image: updatedImage ?? '');
      await FirestoreDatabaseHelper.instance().insertUser(initialUser);
      await SharedPreferenceHelper.instance().insertUser(initialUser);
      return '';
    } on CustomFirebaseAuthException catch (e) {
      return e.message;
    } catch (_) {
      return null;
    }
  }

  Future<void> _singUpWithEmailPassword(BuildContext context) async {
    final _dialogHelper = DialogHelper.instance();
    _dialogHelper
      ..injectContext(context)
      ..showProgressDialog(LocaleKeys.Registering_account.tr());
    final result = await signUp();
    _dialogHelper.dismissProgress();
    if (result == null) {
      await Future.delayed(const Duration(milliseconds: 600));
      _dialogHelper
        ..injectContext(context)
        ..showTitleContentDialog(MaterialDialogContent.networkError(), () => _singUpWithEmailPassword(context));
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
          snackbarMessage: SnackbarMessage.smallMessage(content: LocaleKeys.Register_account_successfully.tr()),
          margin: EdgeInsets.only(left: 25, right: 25, bottom: 90));
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomNavigator()));
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool switchButton = false;
  String errorText = '';
  XFile? _profileImage;
  String editImage = '';

  Future<void> _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _profileImage = pickedImage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> image = AssetImage('assets/mainSplash.png');
    image = (_profileImage?.path == null ? AssetImage('assets/mainSplash.png') : FileImage(File(_profileImage!.path)))
    as ImageProvider<Object>;

    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
                gradient:
                LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primary, black])),
            child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.type == 'feen'
                          ? 'Feen'
                          : widget.type == 'bands'
                          ? 'Bands'
                          : 'Venues',
                      style: t24,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _profileImage != null
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
                      : Container(
                    height: 120,
                    width: 250,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: white,
                        )),
                    child: GestureDetector(
                      onTap: () => _pickImage(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/gallery.png'),
                              Icon(
                                Icons.arrow_upward_rounded,
                                size: 15,
                                color: white,
                              ),
                            ],
                          ),
                          Text(
                            'Add Photos',
                            style: Lightt12,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.type == 'feen'
                          ? 'Username'
                          : widget.type == 'bands'
                          ? 'Band Name'
                          : 'Venue Name',
                      style: Lightt14,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Textfield(
                    onChanged: (String? value) {
                      if (value == null) return;
                      if (value.isNotEmpty) {
                        setState(() {
                          errorText = '';
                        });
                      }
                    },
                    text: name,
                    prefix: 'assets/icons/user.png',
                    hint: widget.type == 'feen'
                        ? 'Username'
                        : widget.type == 'bands'
                        ? 'Band Name'
                        : 'Venue Name',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      LocaleKeys.Email.tr(),
                      style: Lightt14,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Textfield(
                    onChanged: (String? value) {
                      if (value == null) return;
                      if (value.isNotEmpty) {
                        setState(() {
                          errorText = '';
                        });
                      }
                    },
                    text: email,
                    prefix: 'assets/icons/email.png',
                    hint: 'Email',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  widget.type == 'venues'
                      ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      LocaleKeys.Location.tr(),
                      style: Lightt14,
                    ),
                  )
                      : SizedBox(),
                  SizedBox(
                    height: widget.type == 'venues' ? 5 : 0,
                  ),
                  widget.type == 'venues'
                      ? Textfield(
                    onChanged: (String? value) {
                      if (value == null) return;
                      if (value.isNotEmpty) {
                        setState(() {
                          errorText = '';
                        });
                      }
                    },
                    text: location,
                    prefix: 'assets/icons/email.png',
                    hint: 'Location',
                  )
                      : SizedBox(),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      LocaleKeys.Password.tr(),
                      style: Lightt14,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Textfield(
                    onChanged: (String? value) {
                      if (value == null) return;
                      if (value.isNotEmpty) {
                        setState(() {
                          errorText = '';
                        });
                      }
                    },
                    text: password,
                    prefix: 'assets/icons/keyPassword.png',
                    suffix: Icons.remove_red_eye_outlined,
                    hint: 'Password',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Confirm Password',
                      style: Lightt14,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Textfield(
                    onChanged: (String? value) {
                      if (value == null) return;
                      if (value.isNotEmpty) {
                        setState(() {
                          errorText = '';
                        });
                      }
                    },
                    text: confirmPassword,
                    prefix: 'assets/icons/keyPassword.png',
                    suffix: Icons.remove_red_eye_outlined,
                    hint: 'Confirm Password',
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  errorText.isEmpty
                      ? const SizedBox()
                      : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                      margin: const EdgeInsets.only(bottom: 20, top: 15),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: red)),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Icon(Icons.warning_amber_rounded, color: red),
                        const SizedBox(width: 5),
                        Text(errorText, style: TextStyle(color: Colors.red, fontSize: 14))
                      ])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: MyButton(
                      color: primary,
                      name: 'SignUp',
                      onPressed: () {
                        if (name.text.isEmpty) {
                          setState(() {
                            errorText = LocaleKeys.Name_is_required.tr();
                          });
                          return;
                        }
                        if (email.text.isEmpty) {
                          setState(() {
                            errorText = LocaleKeys.email_is_required.tr();
                          });
                          return;
                        }
                        // if (location.text.isEmpty) {
                        //   setState(() {
                        //     errorText = LocaleKeys.email_is_required.tr();
                        //   });
                        //   return;
                        // }
                        if (password.text.isEmpty) {
                          setState(() {
                            errorText = LocaleKeys.password_is_required.tr();
                          });
                          return;
                        }
                        if (confirmPassword.text.isEmpty) {
                          setState(() {
                            errorText = LocaleKeys.Confirm_password_is_required.tr();
                          });
                          return;
                        }
                        _singUpWithEmailPassword(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 12,
                            color: white,
                          ),
                        ),
                        Text('Login',
                            style: TextStyle(
                                fontSize: 12,
                                color: blue,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline))
                      ]))
                ]))));
  }
}
