import 'dart:math';

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
  late Stopwatch _stopwatch;
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCoordinates();
    _stopwatch = Stopwatch();
    _stopwatch.start();
  }

  void _addMarkers() async {
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
    await _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }

  Future<void> _getCoordinates() async {
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
    _addMarkers();
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
                  const Row(
                    children: [
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          // ignore: prefer_const_constructors
                          Text(
                            "00.00.00",
                            style: TextStyle(fontSize: 24.0),
                          ),
                          Text(
                            'Mejor tiempo',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          // ignore: prefer_const_constructors
                          Text(
                            "00.00.00",
                            style: TextStyle(fontSize: 24.0),
                          ),
                          Text(
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
                initialCameraPosition: CameraPosition(
                  target: widget.segmento.endCoordinate,
                  zoom: 13.5,
                ),
                markers: _markers,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
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
