import 'package:easy_localization/easy_localization.dart';
import 'package:event_music_app/Views/Dashboard/bottomNavigation.dart';
import 'package:event_music_app/Views/signup.dart';
import 'package:event_music_app/widgets/button.dart';
import 'package:event_music_app/widgets/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../Helper/texts.dart';
import '../Helper/dialog_helper.dart';
import '../Helper/firebase_auth_helper.dart';
import '../Helper/firestore_database_helper.dart';
import '../Helper/shared_preference_helper.dart';
import '../Helper/snackbar_helper.dart';
import '../data/exception.dart';
import '../data/material_dialog_content.dart';
import '../data/snackbar_message.dart';
import '../translation/locale_keys.g.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool switchButton = false;
  String errorText = '';
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<Object?> login() async {
    try {
      final User user = await FirebaseAuthHelper.instance().signInWithEmailPassword(email.text, password.text);
      if (user.email == null) return null;
      final initialUser = await FirestoreDatabaseHelper.instance().getUser(user.uid);
      if (initialUser == null) return null;
      await SharedPreferenceHelper.instance().insertUser(initialUser);
      return '';
    } on CustomFirebaseAuthException catch (e) {
      return e.message;
    } catch (_) {
      return null;
    }
  }

  Future<void> _singInWithEmailPassword(BuildContext context) async {
    final _dialogHelper = DialogHelper.instance();
    _dialogHelper
      ..injectContext(context)
      ..showProgressDialog(LocaleKeys.Login_account.tr());
    final result = await login();
    _dialogHelper.dismissProgress();
    if (result == null) {
      await Future.delayed(const Duration(milliseconds: 600));
      _dialogHelper
        ..injectContext(context)
        ..showTitleContentDialog(MaterialDialogContent.networkError(), () => _singInWithEmailPassword(context));
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
          snackbarMessage: SnackbarMessage.smallMessage(content: LocaleKeys.Login_account_successfully.tr()),
          margin: EdgeInsets.only(left: 25, right: 25, bottom: 90));
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CustomNavigator()), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primary, black])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/icons/small_logo.png',
                    height: 120,
                  )),
              SizedBox(
                height: 60,
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
                hint: LocaleKeys.Email.tr(),
              ),
              SizedBox(
                height: 20,
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
                hint: LocaleKeys.Password.tr(),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.6,
                        child: CupertinoSwitch(
                          value: switchButton,
                          onChanged: (v) {
                            setState(() {
                              switchButton = v;
                            });
                          },
                          activeColor: blue,
                          trackColor: Colors.grey,
                        ),
                      ),
                      Text(
                        'Remember Me',
                        style: TextStyle(
                          fontSize: 12,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    LocaleKeys.Forgot_your_Password.tr(),
                    style: TextStyle(fontSize: 12, color: white, decoration: TextDecoration.underline),
                  ),
                ],
              ),
              SizedBox(
                height: 120,
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
                  name: LocaleKeys.Login.tr(),
                  onPressed: () {
                    if (email.text.isEmpty) {
                      setState(() {
                        errorText = LocaleKeys.email_is_required.tr();
                      });
                      return;
                    }
                    if (password.text.isEmpty) {
                      setState(() {
                        errorText = LocaleKeys.password_is_required.tr();
                      });
                      return;
                    }

                    _singInWithEmailPassword(context);
                  },
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?  ",
                    style: TextStyle(
                      fontSize: 12,
                      color: white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp(type: 'feen')));
                    },
                    child: Text(
                      'Feen',
                      style: TextStyle(
                          fontSize: 14, color: blue, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      thickness: 1,
                      color: white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUp(
                                    type: 'bands',
                                  )));
                    },
                    child: Text(
                      'Bands',
                      style: TextStyle(
                          fontSize: 14, color: blue, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      thickness: 1,
                      color: white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUp(
                                    type: 'venues',
                                  )));
                    },
                    child: Text(
                      'Venues',
                      style: TextStyle(
                          fontSize: 14, color: blue, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
