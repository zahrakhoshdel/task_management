// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'dart:io' show Platform;

class LocalNotifyManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initSetting;
  BehaviorSubject<ReceiveNotification>
      get DidReceiveLocalNotificationCallback =>
          BehaviorSubject<ReceiveNotification>();

  LocalNotifyManager.init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
    _configureLocalTimeZone();
  }
  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  initializePlatform() {
    var initSettingAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettingIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification notification = ReceiveNotification(
              id: id, title: title, body: body, payload: payload);
          DidReceiveLocalNotificationCallback.add(notification);
        });
    initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIOS);
  }

  setOnNotificationReceive(Function onNotificationReceive) {
    DidReceiveLocalNotificationCallback.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClick(Function OnNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String? payload) async {
      OnNotificationClick(payload);
    });
  }

  Future<void> showNotification() async {
    var androidChannel = const AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    var iosChannel = const IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);
    await flutterLocalNotificationsPlugin.show(
      0,
      'test title',
      'test body',
      platformChannel,
      payload: 'New Payload',
    );
  }

  Future<bool> scheduleNotification(int id1, DateTime taskDate, TimeOfDay time,
      String title, String body) async {
    try {
      final notificationId = UniqueKey().hashCode;

      var androidChannel = const AndroidNotificationDetails(
        'CHANNEL_ID',
        'CHANNEL_NAME',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );
      var iosChannel = const IOSNotificationDetails();
      var platformChannel =
          NotificationDetails(android: androidChannel, iOS: iosChannel);
      await flutterLocalNotificationsPlugin.zonedSchedule(notificationId, title,
          body, _scheduleDaily(taskDate, time), platformChannel,
          payload: 'New Payload',
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
      return true;
    } catch (e) {
      return false;
    }
  }

  static tz.TZDateTime _scheduleDaily(DateTime taskDate, TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, taskDate.year, taskDate.month,
        taskDate.day, time.hour, time.minute, 0);
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }
}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

class ReceiveNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;
  ReceiveNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}
