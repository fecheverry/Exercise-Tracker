import 'package:exercise_tracker/ui/Activity/models/activity_model.dart';
import 'package:exercise_tracker/ui/Activity/pages/activity_history.dart';
import 'package:get/get.dart';

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
        type: "TROTE")
  ].obs;

  List<Activity> get listActivities => List<Activity>.from(_activities
      .where((element) => element.idUser == _userController.userInfo!.id));

  void addActivity(String idUser, String duration, String distance, String date,
      String type) {
    Activity activityToAdd = Activity(
        id: (_activities.length + 1).toString(),
        idUser: idUser,
        duration: duration,
        distance: distance,
        date: date,
        type: type);
    _activities.add(activityToAdd);
    Get.to(() => ActivityFinishedView(activity: activityToAdd));
  }
}
