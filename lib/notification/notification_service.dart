import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  //Hanle displaying of notifications.
  static final NotificationService _notificationService =
      NotificationService._internal();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal() {
    init();
  }

  void init() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void createNotification(
    int count,
    int i,
    countt,
    total,
    String fileName,
  ) {
    //show the notifications.
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel1', 'channel1',
        channelShowBadge: true,
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: true,
        playSound: true,
        showProgress: true,
        maxProgress: count,
        progress: i);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.show(
        0, fileName, '${countt} MB/${total} MB', platformChannelSpecifics,
        payload: 'o');
  }
}
