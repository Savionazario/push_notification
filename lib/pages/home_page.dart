import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notification/models/notification_model.dart';
import 'package:push_notification/services/notification_service.dart';

import '../services/firebase_messaging_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    initialzeFirebaseMessaging();
    super.initState();
  }

  initialzeFirebaseMessaging() async{
    var firebaseMessaging = Provider.of<FirebaseMessagingService>(context, listen: false);
    firebaseMessaging.initialize();
  }
  
  late NotificationService notificationService;

  NotificationModel notification = NotificationModel(
    id: 1,
    title: "Notificação teste",
    body: "Esse é o body da notificação",
    payload: "",
  );

  @override
  Widget build(BuildContext context) {
    notificationService = context.read<NotificationService>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Home Page",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            TextButton(
              onPressed: () {
                notificationService.showNotification(notification);
              },
              child: Text(
                "Show notification",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
