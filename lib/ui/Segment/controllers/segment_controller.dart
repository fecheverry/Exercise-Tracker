import 'package:exercise_tracker/ui/Segment/models/segment_model.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/polyline.dart';
import '../../User/controllers/user_controller.dart';

class SegmentController extends GetxController {
  final UserController _userController = Get.find();
  final List<Segment> _segments = [
    Segment(
        id: "1",
        idUser: "1",
        name: "LA 59",
        start: "CRA 72 #88-61",
        end: "CRA 41 #59-36",
        startCoordinate: const LatLng(0,0),
        endCoordinate: const LatLng(0,0))
  ].obs;

  List<Segment> get allSegments => _segments;
  List<Segment> get mySegments => List<Segment>.from(_segments
      .where((element) => element.idUser == _userController.userInfo!.id));

  get polyline => null;

  void addSegment(String name, String start, String end, LatLng startCoordinate, LatLng endCoordinate) {
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
