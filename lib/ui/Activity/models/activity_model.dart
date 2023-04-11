import 'package:google_maps_flutter/google_maps_flutter.dart';

class Activity {
  final String id;
  final String idUser;
  final String duration;
  final String distance;
  final String date;
  final String type;
  List<TimeSegment> segments;
  final List<LatLng> points;
  Activity(
      {required this.id,
      required this.idUser,
      required this.duration,
      required this.distance,
      required this.date,
      required this.type,
      required this.segments,
      required this.points});
}

class TimeSegment {
  final String id;
  final String idSegment;
    final String segmentName;
  final String time;

  TimeSegment({required this.id, required this.idSegment, required this.time,required this.segmentName});
}
