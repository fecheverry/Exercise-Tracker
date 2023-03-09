import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'User/pages/login.dart';
import 'User/pages/register.dart';
import 'Activity/pages/home.dart';
import 'Activity/pages/activity.dart';
import 'Activity/pages/activity_detail.dart';
import 'Activity/pages/activiy_finished.dart';
import 'Activity/pages/activity_history.dart';
import 'Segment/pages/segment_history.dart';
import 'Segment/pages/segment_detail.dart';

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
      home: SegmentDetailView(
        segmentName: "SEGMENTO 1",
        bestTime: "00.00.00",
        avgTime: "00.00.00",
        start: "CRA1",
        end: "CRA 2",
      ),
    );
  }
}
