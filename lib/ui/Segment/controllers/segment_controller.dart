import 'package:exercise_tracker/ui/Activity/controllers/activity_controller.dart';
import 'package:exercise_tracker/ui/Activity/models/activity_model.dart';
import 'package:exercise_tracker/ui/Segment/models/segment_model.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_history.dart';
import 'package:exercise_tracker/ui/User/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../User/controllers/user_controller.dart';
import 'package:time_machine/time_machine.dart';

class SegmentController extends GetxController {
  final UserController _userController = Get.find();
  final ActivityController _activityController = Get.find();
  final List<Segment> _segments = [
    Segment(
        id: "1",
        idUser: "1",
        name: "LA 59",
        start: "CRA 72 #88-61",
        end: "CRA 41 #59-36",
        startCoordinate: const LatLng(0, 0),
        endCoordinate: const LatLng(0, 0))
  ].obs;

  List<Segment> get allSegments => _segments;
  List<Segment> get mySegments => List<Segment>.from(_segments
      .where((element) => element.idUser == _userController.userInfo!.id));

  String timeBetter(String id) {
    List<TimeSegment> myactinsegment = [];
    for (Activity act in _activityController.listActivities) {
      for (TimeSegment i in act.segments) {
        if (i.idSegment == id) {
          myactinsegment.add(i);
        }
      }
    }
    if (myactinsegment.length == 0) {
      return "00:00:00";
    } else {
      myactinsegment.sort((a, b) => a.time.compareTo(b.time));
      return myactinsegment.first.time;
    }
  }

  String averageTime(String id) {
    List<Time> times = [];
    final formatoTiempo = DateFormat("HH:mm:ss");
    for (Activity act in _activityController.listActivities) {
      for (TimeSegment i in act.segments) {
        if (i.idSegment == id) {
          final tiempo = formatoTiempo.parse(i.time);
          times.add(Time(
              hours: tiempo.hour,
              minutes: tiempo.minute,
              seconds: tiempo.second.toInt()));
        }
      }
    }
    if (times.length == 0) {
      return "00:00:00";
    } else {
      Time avarage = Time(hours: 00, minutes: 00, seconds: 00);
      for (Time i in times) {
        avarage += i;
      }
      return (avarage / times.length).toString().substring(2);
    }
  }

  List<Map<String, String>> ranking(String id) {
    late List<Map<String, String>> list = [];
    Map<String, String> nameTimeMap = {};
    for (Activity act in _activityController.allAcivities) {
      for (TimeSegment i in act.segments) {
        if (i.idSegment == id) {
          for (User user in _userController.allUsers) {
            if (user.id == act.idUser) {
              String name = user.name;
              String time = i.time;
              if (nameTimeMap.containsKey(name)) {
                String currentMinTime = nameTimeMap[name]!;
                if (time.compareTo(currentMinTime) < 0) {
                  nameTimeMap[name] = time;
                }
              } else {
                nameTimeMap[name] = time;
              }
              //list.add({"rank": "", "name": user.name, "time": i.time});
            }
          }
        }
      }
    }
    nameTimeMap.forEach((name, time) {
      list.add({"rank": "", "name": name, "time": time});
    });
    list.sort((a, b) {
      String horaA = a["time"]!;
      String horaB = b["time"]!;
      return horaA.compareTo(horaB);
    });
    for (int i = 0; i < list.length; i++) {
      list[i]["rank"] = (i + 1).toString();
    }
    return list;
  }

  get polyline => null;

  void addSegment(String name, String start, String end, LatLng startCoordinate,
      LatLng endCoordinate) {
    if (name.isNotEmpty && start.isNotEmpty && end.isNotEmpty) {
      Segment segmentToAdd = Segment(
          id: (_segments.length + 1).toString(),
          idUser: _userController.userInfo!.id,
          name: name,
          start: start,
          end: end,
          startCoordinate: startCoordinate,
          endCoordinate: endCoordinate);
      _segments.add(segmentToAdd);
      Get.to(() => const SegmentHistoryView());
    } else {
      Get.snackbar(
        'Error',
        'Rellene todos los campos',
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        borderColor: Colors.amber,
        borderWidth: 1,
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
    }
  }

  void removeSegment(elem) {
    _segments.remove(elem);
  }

  void setPolyline(Polyline polyline) {}
}
