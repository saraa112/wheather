import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:school/src/app_root.dart';


void main()
  async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(AppRoot());
}
