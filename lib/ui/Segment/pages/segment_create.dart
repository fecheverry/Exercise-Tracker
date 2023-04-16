import 'dart:math';
import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class SegmentCreationView extends StatefulWidget {
  const SegmentCreationView({super.key});

  @override
  State<SegmentCreationView> createState() => _SegmentCreationViewState();
}

class _SegmentCreationViewState extends State<SegmentCreationView> {
  final SegmentController _segmentController = Get.find();
  final TextEditingController _segmentNameController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final Set<Marker> _markers = <Marker>{};

  String api = "AIzaSyCBAAbxPf6EqElO7EcuWbmkmC-Stc7y_0w";

  late LatLng _startCoordinate = const LatLng(0, 0);
  late LatLng _endCoordinate = const LatLng(0, 0);
  late GoogleMapController _mapController;

  void trazarruta() {
    if (_segmentNameController.text.isNotEmpty &&
        _startController.text.isNotEmpty &&
        _endController.text.isNotEmpty) {
      locationFromAddress('Barranquilla, CO ${_startController.text}')
          .then((startLocation) {
        locationFromAddress('Barranquilla, CO ${_endController.text}')
            .then((endLocation) {
          _startCoordinate =
              LatLng(startLocation[0].latitude, startLocation[0].longitude);
          _endCoordinate =
              LatLng(endLocation[0].latitude, endLocation[0].longitude);

          Marker startMarker = Marker(
            markerId: const MarkerId('Inicio'),
            position: _startCoordinate,
          );
          Marker endMarker = Marker(
            markerId: const MarkerId('Fin'),
            position: _endCoordinate,
          );

          setState(() {
            _markers.clear();
            _markers.add(startMarker);
            _markers.add(endMarker);
          });

          final bounds = LatLngBounds(
            southwest: LatLng(
              min(_startCoordinate.latitude, _endCoordinate.latitude),
              min(_startCoordinate.longitude, _endCoordinate.longitude),
            ),
            northeast: LatLng(
              max(_startCoordinate.latitude, _endCoordinate.latitude),
              max(_startCoordinate.longitude, _endCoordinate.longitude),
            ),
          );
          _mapController.animateCamera(
            CameraUpdate.newLatLngBounds(bounds, 50),
          );
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, //remover sombra
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.amber[400],
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'CREAR SEGMENTO',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: const Key("name_input"),
              controller: _segmentNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del segmento',
              ),
            ),
            TextField(
              key: const Key("start_input"),
              controller: _startController,
              decoration: const InputDecoration(
                labelText: 'Inicio',
              ),
            ),
            TextField(
              key: const Key("end_input"),
              controller: _endController,
              decoration: const InputDecoration(
                labelText: 'Fin',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(10.979085, -74.804974),
                  zoom: 10,
                ),
                markers: _markers,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
              ),
            ),
            const Spacer(),
            Row(
              children: [
                ElevatedButton(
                  key: const Key("rute_button"),
                  onPressed: () {
                    if (_segmentNameController.text.isNotEmpty &&
                        _startController.text.isNotEmpty &&
                        _endController.text.isNotEmpty) {
                      trazarruta();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: const Text('TRAZAR RUTA'),
                ),
                const Spacer(),
                ElevatedButton(
                  key: const Key("create_button"),
                  onPressed: () {
                    if (_segmentNameController.text.isNotEmpty &&
                        _startController.text.isNotEmpty &&
                        _endController.text.isNotEmpty) {
                      _segmentController.addSegment(
                          _segmentNameController.text,
                          _startController.text,
                          _endController.text,
                          _startCoordinate,
                          _endCoordinate);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: const Text('CREAR SEGMENTO'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
