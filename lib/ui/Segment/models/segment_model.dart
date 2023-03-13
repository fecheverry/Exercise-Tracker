class Segment {
  final String id;
  final String name;
  final String start;
  final String end;
  List<Segment> segments;
  Segment(
      {required this.id,
      required this.name,
      required this.start,
      required this.end,
      required this.segments});
}
