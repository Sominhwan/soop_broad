

import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  final FlutterLocalNotificationsPlugin _local = FlutterLocalNotificationsPlugin();

  /// Andorid
  // channelId : 고유한 id 값을 사용.
  // channelName : 앱 설정 > 알림에 보여지는 네임.
  // channelDescription : 해당 채널에 대한 설명.
  // importance, priority : 중요도를 설정하는 부분으로 아래와 같이 중요도를 높혀서 전송을 해야지만 Foreground에서 노출이 가능함.
  /// IOS
  // presentAlert, presentBadge, presentSound : 얼럿, 배지, 사운드 활성화.
  // badgeNumber : 배지 카운트를 넣어주는 부분으로, 앱 아이콘 배지 넘버이다.
  // ios는 앱 아이콘 배지 넘버를 직접 지정해 주지 않으면 카운트를 시스템에서 처리해주지 않기 때문에, 지정하지 않으면 카운트는 표시되지 않습니다.
  NotificationDetails details = const NotificationDetails(
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
    android: AndroidNotificationDetails(
      "1",
      "test",
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true, // 알림 계속 유지
      autoCancel: false, // 사용자가 알림을 클릭해도 알림이 사라지지 않도록 설정
    ),
  );

  void initialization() async {
    log('flutter local notification 초기화');
    AndroidInitializationSettings android = const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings ios = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    InitializationSettings settings =
    InitializationSettings(android: android, iOS: ios);
    await _local.initialize(settings);
  }

  void initializationTime() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
  }

  void sendMessage() async {
    /// show(id, title, body, notificationDetails, payload
    // id : Unique Id, 중복되지 않아야 함. 알림 그룹별로 id 값을 지정하여 사용함.
    // title : 제목 영역이 보여지는 부분에 노출되는 영역.
    // body : 제목 아래 본문 내용에 노출되는 영역.
    // payload : 알림을 터치하여 앱에 진입 했을 때에, 수신 가능한 부분으로, 주로 네임드 라우터에 사용하는 path를 사용함.
    // notificationDetails : 플랫폼 (android, ios, macOS, linux) 별로 로컬 푸시의 세부 설정을 할 수 있는 부분이다.
    await _local.show(1, '타이틀', '내용', details);
  }

  void sendPeriodicallyMessage() async {
    // 2024-01-22 00:00:00.000Z
    // tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime schedule = tz.TZDateTime.now(tz.local).add(const Duration(minutes: 5));

    await _local.zonedSchedule(
      1,
      '주제',
      '시간 전송',
      schedule,
      details,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: null,
    );
  }
}