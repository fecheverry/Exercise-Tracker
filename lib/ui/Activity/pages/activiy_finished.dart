import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/activity_model.dart';
import 'activity_history.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class ActivityFinishedView extends StatefulWidget {
  final Activity activity;
  const ActivityFinishedView({super.key, required this.activity});

  @override
  State<ActivityFinishedView> createState() => _ActivityFinishedViewState();
}

class _ActivityFinishedViewState extends State<ActivityFinishedView> {
  late Stopwatch _stopwatch;
  late GoogleMapController _mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  late Polyline _polyline;

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
    _polyline = Polyline(
      polylineId: PolylineId("line"),
      color: Colors.red,
      width: 5,
      points: widget.activity.points,
    );
    Geolocator.getPositionStream().listen((position) {
      final LatLng latLng = LatLng(position.latitude, position.longitude);
      _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
    }); // Posición inicial del mapa
    _stopwatch.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, //remover sombra
        leading: IconButton(
          icon: const Icon(Icons.save_alt),
          color: Colors.amber[400],
          onPressed: () {
            Get.to(() => const ActivityHistoryView());
          },
        ),
        title: const Text(
          'GUARDAR',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  "Duracion",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const Spacer(),
                // ignore: prefer_const_constructors
                Text(
                  widget.activity.duration,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  "Distancia",
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                    fontSize: 30,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.activity.distance,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: widget.activity.points.first,
                  zoom: 15,
                ),
                polylines: Set<Polyline>.from([_polyline]),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 1,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'SEGMENTOS',
                    style: TextStyle(
                      color: Colors.amber[400],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 90,
                  height: 1,
                  color: Colors.black,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.activity.segments.length,
                itemBuilder: (context, index) {
                  final segmento = widget.activity.segments[index];
                  return ListTile(
                    title: Text(segmento.segmentName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Tiempo: ${segmento.time}')],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
