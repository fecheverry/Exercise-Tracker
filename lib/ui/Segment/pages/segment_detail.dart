import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/segment_model.dart';

class SegmentDetailView extends StatefulWidget {
  final Segment segmento;
  SegmentDetailView({super.key, required this.segmento});

  @override
  State<SegmentDetailView> createState() => _SegmentDetailViewState();
}

class _SegmentDetailViewState extends State<SegmentDetailView> {
  late Stopwatch _stopwatch;
  late LatLng _initialCameraPosition;
  late GoogleMapController _mapController;
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
    _initialCameraPosition =
        const LatLng(11.019211, -74.850314); // Posición inicial del mapa
    _stopwatch.start();
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
                            "00.00.00",
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
                            "00.00.00",
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
