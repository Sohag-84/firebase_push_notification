// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //for forground state
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
        }
      },
    );

    //app is opened but terminated
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print(message.data['path']);
          Navigator.pushNamed(context, message.data['path']);
        }
      },
    );

    //when the app is terminated
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print(message.data['path']);
          Navigator.pushNamed(context, message.data['path']);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Home screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
