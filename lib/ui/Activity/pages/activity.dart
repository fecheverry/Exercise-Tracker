import 'dart:async';
import 'package:exercise_tracker/ui/Activity/controllers/activity_controller.dart';
import 'package:exercise_tracker/ui/Activity/models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Segment/models/segment_model.dart';
import '../../User/controllers/user_controller.dart';
import 'activiy_finished.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

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
  final UserController _userController = Get.find();
  final ActivityController _activityController = Get.find();
  late Stopwatch _stopwatch;
  late Timer _timer;
  late LatLng _initialCameraPosition;
  late GoogleMapController _mapController;
  bool _isRunning = true;
  bool myLocationEnabled = false;

  Future<void> _getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final LatLng latLng = LatLng(position.latitude, position.longitude);
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _stopwatch = Stopwatch();
    Geolocator.getPositionStream().listen((position) {
      final LatLng latLng = LatLng(position.latitude, position.longitude);
      _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
    });
    _timer = Timer.periodic(const Duration(milliseconds: 10), _updateTimer);
    _initialCameraPosition =
        const LatLng(11.019211, -74.850314); // Posición inicial del mapa
    _stopwatch.start();
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop(); // Cancelar la suscripción al stream de ubicación
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
    setState(() {});
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
      /*appBar: AppBar(
        title: const Text('Mapa'),
      ),*/
      body: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            _formattedTime(_stopwatch.elapsed),
            style: const TextStyle(fontSize: 65),
          ),
          const Text(
            "Duracion",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            "0.00",
            style: TextStyle(fontSize: 65),
          ),
          const Text(
            "Distancia",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: _initialCameraPosition,
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                setState(() {
                  myLocationEnabled = true;
                });
              },
              myLocationEnabled: myLocationEnabled,
            ),
          ),
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
                        "00.0",
                        DateTime.now().toString(),
                        widget.type,
                        widget.segments);
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
