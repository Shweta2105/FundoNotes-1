import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

NotificationPlugins notificationPlugins = NotificationPlugins._();

class NotificationPlugins {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotification> didReceivedNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  var initializeSetting;
  NotificationPlugins._() {
    init();
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializePlatform();
  }

  initializePlatform() {
    var initializeAndroid = const AndroidInitializationSettings('noti_icon');
    initializeSetting = InitializationSettings(android: initializeAndroid);
  }

  setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(
      initializeSetting,
      onSelectNotification: (String? payload) async {
        onNotificationClick(payload);
      },
    );
  }

  Future<void> showNotification([String? payload]) async {
    var time = DateTime.now();
    var android = AndroidNotificationDetails('CHANNEL_ID', 'CHANNEL_NAME',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        timeoutAfter: 5000,
        styleInformation: DefaultStyleInformation(true, true));
    var platform = NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(
        0, '<b>local check</b>', 'FundooNotes', platform,
        payload: payload! + ' ${time.hour} :${time.minute}');
  }
}

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}
