import 'dart:async';
import 'package:exercise_tracker/ui/Activity/controllers/activity_controller.dart';
import 'package:exercise_tracker/ui/Activity/models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class ActivityView extends StatefulWidget {
  final String type;

  List<TimeSegment> segments = [
    TimeSegment(
        id: "01", idSegment: "00", time: "00:00:00", segmentName: "LA 59")
  ];
  ActivityView({super.key, required this.type});

  @override
  // ignore: library_private_types_in_public_api
  _ActivityViewState createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  final ActivityController _activityController = Get.find();
  late Stopwatch _stopwatch;
  late Timer _timer;
  double distancefinal = 0;
  double distance = 0;
  bool _isRunning = true;
  bool myLocationEnabled = false;
  List<LatLng> points = [];
  StreamSubscription<Position>? _positionStreamSubscription;

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 1,
  );

  @override
  void initState() {
    super.initState();
    _positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        LatLng latLng = LatLng(position.latitude, position.longitude);
        setState(() {
          points.add(latLng);
          if (points.length > 1) {
            _distence();
          }
        });
      }
    });
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 10), _updateTimer);
    _stopwatch.start();
  }

  void _distence() {
    distance = Geolocator.distanceBetween(
        points.last.latitude,
        points.last.longitude,
        points[points.length - 2].latitude,
        points[points.length - 2].longitude);
    distancefinal = distance + distancefinal;
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  void _updateTimer(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {});
    }
  }

  void _pauseResumeTimer() {
    if (_isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 10), _updateTimer);
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _stopTimer() {
    _timer.cancel();
    _stopwatch.stop();
    _stopwatch.reset();
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
    }
  }

  String _formattedTime(Duration duration) {
    String twoDigitMinutes = _twoDigits((duration.inMinutes.remainder(60)));
    String twoDigitSeconds = _twoDigits((duration.inSeconds.remainder(60)));
    String twoDigitHours = _twoDigits((duration.inHours));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Card(
            elevation: 5, // Altura de la sombra de la tarjeta
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(color: Colors.amber, width: 2.0),
            ), // Bordes curvos
            color: Colors.white, // Color de la tarjeta
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 40),
                  Text(
                    _formattedTime(_stopwatch.elapsed),
                    style: const TextStyle(fontSize: 65, color: Colors.black),
                  ),
                  const Text(
                    "Duracion",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    distancefinal.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 65, color: Colors.black),
                  ),
                  const Text(
                    "Distancia",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 10,
                child: ElevatedButton(
                  onPressed: _pauseResumeTimer,
                  child: _isRunning
                      ? const Text(
                          "PAUSAR",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        )
                      : const Text(
                          "CONTINUAR",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 10,
                child: ElevatedButton(
                  onPressed: () {
                    _activityController.addActivity(
                        _formattedTime(_stopwatch.elapsed),
                        distancefinal.toStringAsFixed(2),
                        DateTime.now().toString(),
                        widget.type,
                        widget.segments,
                        points);
                    _stopTimer();
                  },
                  child: const Text(
                    "FINALIZAR",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
