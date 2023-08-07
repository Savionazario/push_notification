import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:push_notification/models/notification_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidNotificationDetails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimezone();
    await initializeNotifications();
  }

  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  initializeNotifications() async {
    const android = AndroidInitializationSettings("ic_icon");
    // Fazer para IOS

    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      // onDidReceiveNotificationResponse: _onSelectNotification,
    );
  }

  // _onSelectNotification(String? payload){
  //   if(payload != null && payload.isNotEmpty){
  //     print("Esse é o payload: $payload");
  //   }
  // }

  showNotification(NotificationModel notification) {
    androidNotificationDetails = const AndroidNotificationDetails(
      "alerts_notifications",
      "Alerts",
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );

    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidNotificationDetails,
      ),
    );
  }

  //! Para checar se existe notificação quando abrir o app
  // checkForNotifications() async{
  //   final details = await localNotificationsPlugin.getNotificationAppLaunchDetails();

  //   if(details != null && details.didNotificationLaunchApp){

  //   }
  // }
}
