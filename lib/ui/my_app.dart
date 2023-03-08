import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'User/pages/login.dart';
import 'User/pages/register.dart';
import 'Activity/pages/home.dart';
import 'Activity/pages/activity.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Exercise Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: CronometroPage(),
    );
  }
}
