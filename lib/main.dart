import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recap/constans.dart';
import 'package:recap/firebase_options.dart';
import 'package:recap/pages/chat.dart';
import 'package:recap/pages/login.dart';
import 'package:recap/pages/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    // optionally send error reports
  };

  runZonedGuarded(
    () {
      runApp(MyApp());
    },
    (error, stack) {
      print('🔴 Uncaught error: $error');
      print(stack);
    },
  );

  // Handle platform exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    print('Platform Error: $error');
    print('Stack trace: $stack');
    return true;
  };
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Constans.primiryColor),
      routes: {
        "${LoginPage.id}": (context) => LoginPage(),
        "${RegisterPage.id}": (context) => RegisterPage(),
        "${ChatPage.id}": (context) => ChatPage(),
      },
      initialRoute: "${LoginPage.id}",
    );
  }
}
