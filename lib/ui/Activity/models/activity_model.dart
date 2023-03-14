class Activity {
  final String id;
  final String idUser;
  final String duration;
  final String distance;
  final String date;
  final String type;
  List<TimeSegment> segments;
  Activity(
      {required this.id,
      required this.idUser,
      required this.duration,
      required this.distance,
      required this.date,
      required this.type,
      required this.segments});
}

class TimeSegment {
  final String id;
  final String idSegment;
    final String segmentName;
  final String time;

  TimeSegment({required this.id, required this.idSegment, required this.time,required this.segmentName});
}
