

import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  final FlutterLocalNotificationsPlugin _local = FlutterLocalNotificationsPlugin();

  static final LocalNotification _instance = LocalNotification._internal();

  factory LocalNotification() {
    return _instance;
  }

  LocalNotification._internal();

  /// local notification 초기화
  void initialization() async {
    log('flutter local notification 초기화');
    AndroidInitializationSettings android = const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings ios = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    InitializationSettings settings = InitializationSettings(android: android, iOS: ios);
    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: notificationResponse
    );
  }

  /// local notification 시간 초기화
  void initializationTime() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
  }

  /// local payload 이벤트 처리
  void notificationResponse(NotificationResponse details) async {
    log('Notification payload: ${details.payload}');
    if (details.payload != null) {
      _handleNotificationPayload(details.payload);
    }
  }
  void _handleNotificationPayload(String? payload) {
    log('Handling notification payload: $payload');
  }

  /// local notification 보내기
  void sendMessage({
    required String channelId,
    required int id,
    required bool foregroundAlarm,
    required bool ongoing,
    required bool autoCancel,
    String? subText,
    bool showWhen = false,
    String? title,
    String? content,
    String? payload
  }) async {
    NotificationDetails details = NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: foregroundAlarm, // 알림
        presentBadge: foregroundAlarm, // 배지
        presentSound: foregroundAlarm, // 사운드
      ),
      android: AndroidNotificationDetails(
        channelId, // channelId : 고유한 id 값을 사용.
        'soop_broad', // channelName : 앱 설정 > 알림에 보여지는 네임.
        subText: subText, // subTitle
        showWhen: showWhen, // 알림 시간 표시 여부
        importance: Importance.max,
        priority: Priority.high,
        ongoing: ongoing, // 알림 계속 유지
        autoCancel: autoCancel, // 사용자가 알림을 클릭해도 알림이 사라지지 않도록 설정
      ),
    );

    await _local.show(id, title, content, details, payload: payload);
  }

  /// local notification 시간별 보내기
  // void sendPeriodicallyMessage() async {
  //   // 2024-01-22 00:00:00.000Z
  //   // tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   tz.TZDateTime schedule = tz.TZDateTime.now(tz.local).add(const Duration(minutes: 5));
  //
  //   await _local.zonedSchedule(
  //     1,
  //     '주제',
  //     '시간 전송',
  //     schedule,
  //     details,
  //     uiLocalNotificationDateInterpretation:
  //     UILocalNotificationDateInterpretation.absoluteTime,
  //     matchDateTimeComponents: null,
  //   );
  // }

  /// local notification 취소
  void cancel(int channelId) async {
    await _local.cancel(channelId);
  }
  
  /// local notification 전체쥐소
  void cancelAll() async {
    await _local.cancelAll();
  }
}