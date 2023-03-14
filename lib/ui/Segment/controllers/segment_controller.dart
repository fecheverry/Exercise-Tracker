import 'package:exercise_tracker/ui/Segment/models/segment_model.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_history.dart';
import 'package:get/get.dart';

import '../../User/controllers/user_controller.dart';

class SegmentController extends GetxController {
  final UserController _userController = Get.find();
  final List<Segment> _segments = [
    Segment(
        id: "1",
        idUser: "1",
        name: "LA 59",
        start: "CRA 72 #88-61",
        end: "CRA 41 #59-36")
  ];

  List<Segment> get allSegments => _segments;
  List<Segment> get mySegments => List<Segment>.from(_segments
      .where((element) => element.idUser == _userController.userInfo!.id));

  void addSegment(String name, String start, String end) {
    Segment segmentToAdd = Segment(
        id: (_segments.length + 1).toString(),
        idUser: _userController.userInfo!.id,
        name: name,
        start: start,
        end: end);
    _segments.add(segmentToAdd);
    Get.to(() => const SegmentHistoryView());
  }
}
