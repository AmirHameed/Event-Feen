import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal();

  static NotificationHelper instance() {
    _instance ??= NotificationHelper._internal();
    return _instance!;
  }

  final _random = Random(1);
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

  static const _androidInitializationSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
  static const _androidPlatformChannelSpecifies = AndroidNotificationDetails(
      'com.tiktaka.tiktaka', 'TikTaka Notification',
      channelDescription: 'general notification',
      styleInformation: BigTextStyleInformation(''),
      importance: Importance.high,
      playSound: true,
      priority: Priority.max,
      enableLights: true);
  static const _notificationDetails = NotificationDetails(
      android: _androidPlatformChannelSpecifies, iOS: DarwinNotificationDetails(presentSound: true));

  DarwinInitializationSettings get _darwinInitializationSettings =>
      DarwinInitializationSettings(onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

  InitializationSettings get _initializationSettings =>
      InitializationSettings(android: _androidInitializationSetting, iOS: _darwinInitializationSettings);

  Future<void> _onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    print(payload);
  }

  bool isPluginInitialize = false;

  int get _randomNumber => int.parse(List.generate(6, (_) => _random.nextInt(9)).join());

  Future<String?> getLastPayload() async {
    final notificationDetails = await _flutterLocalNotificationPlugin.getNotificationAppLaunchDetails();
    return notificationDetails?.notificationResponse?.payload;
  }

  Future<void> showNotification(
      {required String title,
      required String content,
      String route = '',
      Map<String, dynamic>? arguments,
      String? payload}) async {
    if (!isPluginInitialize) {
      await _flutterLocalNotificationPlugin.initialize(_initializationSettings, onDidReceiveNotificationResponse: (s) {
        if (route.isNotEmpty) Get.toNamed(route, arguments: arguments);
      });
      if (route.isNotEmpty) isPluginInitialize = true;
    }
    _flutterLocalNotificationPlugin.show(_randomNumber, title, content, _notificationDetails, payload: payload);
  }
}
