import 'package:exercise_tracker/ui/Activity/models/activity_model.dart';
import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:exercise_tracker/ui/Segment/models/segment_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../User/controllers/user_controller.dart';
import '../pages/activiy_finished.dart';

class ActivityController extends GetxController {
  final UserController _userController = Get.find();
  final List<Activity> _activities = [
    Activity(
        id: "1",
        idUser: "1",
        duration: "00:00:00",
        distance: "00.0",
        date: "date",
        type: "TROTE",
        segments: [],
        points: [])
  ].obs;

  List<Activity> get listActivities => List<Activity>.from(_activities
      .where((element) => element.idUser == _userController.userInfo!.id));

  void addActivity(String duration, String distance, String date, String type, List<TimeSegment> segments,
      List<LatLng> points) {
    Activity activityToAdd = Activity(
        id: (_activities.length + 1).toString(),
        idUser: _userController.userInfo!.id,
        duration: duration,
        distance: distance,
        date: date,
        type: type,
        segments: segments,
        points: points);
    _activities.add(activityToAdd);
    Get.to(() => ActivityFinishedView(activity: activityToAdd));
  }

  void removeAvtivity(int index) {
    _activities.removeWhere((elemento) => elemento == listActivities[index]);
  }
}
