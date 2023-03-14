import '../../Segment/models/segment_model.dart';

class Activity {
  final String id;
  final String idUser;
  final String duration;
  final String distance;
  final String date;
  final String type;
  List<Segment> segments;
  Activity(
      {required this.id,
      required this.idUser,
      required this.duration,
      required this.distance,
      required this.date,
      required this.type,required this.segments});
}
