import 'package:google_maps_flutter/google_maps_flutter.dart';

class Segment {
  final String id;
  final String idUser;
  final String name;
  final String start;
  final String end;
  final LatLng startCoordinate;
  final LatLng endCoordinate;
  Segment({
    required this.id,
    required this.idUser,
    required this.name,
    required this.start,
    required this.end,
    required this.startCoordinate,
    required this.endCoordinate
  });
}
