import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../models/activity_model.dart';

class ActivityDetailView extends StatefulWidget {
  final Activity actividad;

  // ignore: empty_constructor_bodies
  ActivityDetailView({super.key, required this.actividad}) {}

  @override
  State<ActivityDetailView> createState() => _ActivityDetailViewState();
}

class _ActivityDetailViewState extends State<ActivityDetailView> {
  late Stopwatch _stopwatch;
  late GoogleMapController _mapController;
  bool myLocationEnabled = false;
  PolylinePoints polylinePoints = PolylinePoints();
  late Polyline _polyline;

  @override
  void initState() {
    super.initState();
    _polyline = Polyline(
      polylineId: const PolylineId("Ruta"),
      color: Colors.red,
      width: 5,
      points: widget.actividad.points,
    );
    _stopwatch = Stopwatch();
    _stopwatch.start();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    final bounds = LatLngBounds(
      southwest: LatLng(
        min(widget.actividad.points.first.latitude,
            widget.actividad.points.last.latitude),
        min(widget.actividad.points.first.longitude,
            widget.actividad.points.last.longitude),
      ),
      northeast: LatLng(
        max(widget.actividad.points.first.latitude,
            widget.actividad.points.last.latitude),
        max(widget.actividad.points.first.longitude,
            widget.actividad.points.last.longitude),
      ),
    );
    _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
    Future.delayed(Duration(milliseconds: 500), () {
      _mapController.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 50),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, //remover sombra
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.amber[400],
          onPressed: () => Get.back(),
        ),
        // ignore: prefer_const_constructors
        title: Text(
          widget.actividad.type,
          style: const TextStyle(color: Colors.amber),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // ignore: prefer_const_constructors
                    Text(
                      widget.actividad.duration,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Duracion",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 150,
                ),
                Column(
                  children: [
                    Text(
                      widget.actividad.distance,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Recorrido",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(10.979085, -74.804974),
                  zoom: 10,
                ),
                polylines: Set<Polyline>.from([_polyline]),
                onMapCreated: _onMapCreated,
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
                itemCount: widget.actividad.segments.length,
                itemBuilder: (context, index) {
                  final segmento = widget.actividad.segments[index];
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
