import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification/models/notification_model.dart';
import 'package:push_notification/services/notification_service.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  //Method reponsible for initialize firebase configs and listen to new messages that come for the server
  Future<void> initialize() async {
    // Foreground app config (when the app is open)
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
      
    );

    getDeviceFirebaseToken();
    _onMessage();
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("-------------------------------");
    print("Firebase token: $token");
    print("-------------------------------");
  }

  // Method reponsible for capture messaging of notification while the user is using the app
  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? remoteNotification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;

      if (remoteNotification != null && androidNotification != null) {
        // Create a object of NotificationModel
        NotificationModel notificationModel = NotificationModel(
          id: androidNotification.hashCode,
          title: remoteNotification.title,
          body: remoteNotification.body,
          payload: "",
        );

        // Call the method showNotification to display the recieved notification
        _notificationService.showNotification(notificationModel);
      }
    });
  }
}
