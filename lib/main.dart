
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:school/modules/auth_view.dart';
import 'package:school/src/app_root.dart';
import 'notification.dart';


  void main()
  async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(messageHandler);
    firebaseMessagingListener();

    runApp(AppRoot());
}
