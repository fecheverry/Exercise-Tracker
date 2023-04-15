import 'dart:math';

import 'package:exercise_tracker/ui/Activity/controllers/activity_controller.dart';
import 'package:exercise_tracker/ui/Activity/models/activity_model.dart';
import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/segment_model.dart';

class SegmentDetailView extends StatefulWidget {
  final Segment segmento;
  const SegmentDetailView({super.key, required this.segmento});

  @override
  State<SegmentDetailView> createState() => _SegmentDetailViewState();
}

class _SegmentDetailViewState extends State<SegmentDetailView> {
  final SegmentController _segmentController = Get.find();
  late Stopwatch _stopwatch;
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  late Set<TimeSegment> missegmentos;
  late String timeBetter;
  late String averagetime;

  @override
  void initState() {
    super.initState();
    timeBetter = mejortime(widget.segmento.id);
    averagetime = promediotime(widget.segmento.id);
    _addmarkers();
    _stopwatch = Stopwatch();
    _stopwatch.start();
  }

  Future<void> _addmarkers() async {
    _markers = {
      Marker(
        markerId: const MarkerId('start'),
        position: widget.segmento.startCoordinate,
        infoWindow: InfoWindow(title: 'Inicio', snippet: widget.segmento.start),
      ),
      Marker(
        markerId: const MarkerId('end'),
        position: widget.segmento.endCoordinate,
        infoWindow: InfoWindow(title: 'Fin', snippet: widget.segmento.end),
      ),
    };
  }

  String promediotime(String id) {
    return _segmentController.averageTime(id);
  }

  String mejortime(String id) {
    return _segmentController.timeBetter(id);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    final bounds = LatLngBounds(
      southwest: LatLng(
        min(widget.segmento.startCoordinate.latitude,
            widget.segmento.endCoordinate.latitude),
        min(widget.segmento.startCoordinate.longitude,
            widget.segmento.endCoordinate.longitude),
      ),
      northeast: LatLng(
        max(widget.segmento.startCoordinate.latitude,
            widget.segmento.endCoordinate.latitude),
        max(widget.segmento.startCoordinate.longitude,
            widget.segmento.endCoordinate.longitude),
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

  final List<Map<String, String>> _rankingData = [
    {"rank": "1", "name": "John Doe", "time": "2:45:12"},
    {"rank": "2", "name": "Jane Smith", "time": "3:01:45"},
    {"rank": "3", "name": "Bob Johnson", "time": "3:05:22"},
    {"rank": "4", "name": "Emily Brown", "time": "3:10:11"},
    {"rank": "5", "name": "Mike Wilson", "time": "3:15:00"},
    {"rank": "1", "name": "John Doe", "time": "2:45:12"},
    {"rank": "2", "name": "Jane Smith", "time": "3:01:45"},
    {"rank": "3", "name": "Bob Johnson", "time": "3:05:22"},
    {"rank": "4", "name": "Emily Brown", "time": "3:10:11"},
    {"rank": "5", "name": "Mike Wilson", "time": "3:15:00"},
    {"rank": "1", "name": "John Doe", "time": "2:45:12"},
    {"rank": "2", "name": "Jane Smith", "time": "3:01:45"},
    {"rank": "3", "name": "Bob Johnson", "time": "3:05:22"},
    {"rank": "4", "name": "Emily Brown", "time": "3:10:11"},
    {"rank": "5", "name": "Mike Wilson", "time": "3:15:00"},
  ];

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
          widget.segmento.name,
          style: const TextStyle(color: Colors.amber),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          // ignore: prefer_const_constructors
                          Text(
                            timeBetter,
                            style: const TextStyle(fontSize: 24.0),
                          ),
                          const Text(
                            'Mejor tiempo',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          // ignore: prefer_const_constructors
                          Text(
                            averagetime,
                            style: const TextStyle(fontSize: 24.0),
                          ),
                          const Text(
                            'Tiempo promedio',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Row(
                    children: [
                      Icon(
                        Icons.control_point,
                        color: Colors.amber[400],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      // ignore: prefer_const_constructors
                      Text(
                        widget.segmento.start,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Icon(
                        Icons.control_point,
                        color: Colors.amber[400],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      // ignore: prefer_const_constructors
                      Text(
                        widget.segmento.end,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(10.979085, -74.804974),
                  zoom: 10,
                ),
                markers: _markers,
                onMapCreated: _onMapCreated,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Ranking:',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            DataTable(
              columns: const [
                DataColumn(label: Text('Pos.')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Tiempo')),
              ],
              rows: _rankingData
                  .map(
                    (data) => DataRow(
                      cells: [
                        DataCell(Text(data['rank']!)),
                        DataCell(Text(data['name']!)),
                        DataCell(Text(data['time']!)),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
