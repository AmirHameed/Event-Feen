import 'package:easy_localization/easy_localization.dart';
import 'package:event_music_app/Views/splash.dart';
import 'package:event_music_app/translation/codegen_loader.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Helper/shared_preference_helper.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferenceHelper.initializeSharedPreferences();
  final isEnglish = SharedPreferenceHelper.instance().isEnglish;
  final locale = isEnglish ? Locale('en') : Locale('ar');
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('ar')],
      assetLoader: const CodegenLoader(),
      startLocale: locale,
      fallbackLocale: locale,
      child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      title: 'Event Feen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: Splash(),
    );
  }
}
