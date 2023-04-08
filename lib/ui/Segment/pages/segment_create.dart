import 'dart:math';
import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SegmentCreationView extends StatelessWidget {
  SegmentController _segmentController = Get.find();

  final TextEditingController _segmentNameController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final polylinePoints = PolylinePoints();

  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  LatLng? _startCoordinate;
  LatLng? _endCoordinate;

  Future<void> _getCoordinates() async {
    final startLocations =
        await locationFromAddress('Barranquilla, CO ${_startController.text}');
    final endLocations =
        await locationFromAddress('Barranquilla, CO ${_endController.text}');

    if (startLocations.isNotEmpty) {
      _startCoordinate =
          LatLng(startLocations[0].latitude, startLocations[0].longitude);
    }

    if (endLocations.isNotEmpty) {
      _endCoordinate =
          LatLng(endLocations[0].latitude, endLocations[0].longitude);
    }
    // Crear marcadores
    if (_startCoordinate != null && _endCoordinate != null) {
      // Eliminar marcadores y ruta existentes
      _markers.clear();

      // Crear marcadores
      _markers = {
        Marker(
          markerId: const MarkerId('start'),
          position: _startCoordinate!,
          infoWindow:
              InfoWindow(title: 'Inicio', snippet: _startController.text),
        ),
        Marker(
          markerId: const MarkerId('end'),
          position: _endCoordinate!,
          infoWindow: InfoWindow(title: 'Fin', snippet: _endController.text),
        ),
      };
    }
    _addMarkers();
  }

  void _addMarkers() async {
    if (_startCoordinate != null && _endCoordinate != null) {
      final bounds = LatLngBounds(
        southwest: LatLng(
          min(_startCoordinate!.latitude, _endCoordinate!.latitude),
          min(_startCoordinate!.longitude, _endCoordinate!.longitude),
        ),
        northeast: LatLng(
          max(_startCoordinate!.latitude, _endCoordinate!.latitude),
          max(_startCoordinate!.longitude, _endCoordinate!.longitude),
        ),
      );
      await _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 50),
      );
    }
  }

  //AIzaSyCBAAbxPf6EqElO7EcuWbmkmC-Stc7y_0w
  /*final startLocations = await locationFromAddress(_startController.text);
    final endLocations = await locationFromAddress(_endController.text);*/

  SegmentCreationView({super.key});

  GoogleMapController? _mapController;

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
                  target: LatLng(11.019211, -74.850314),
                  zoom: 15,
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
                  onPressed: () async {
                    await _getCoordinates();
                  },
                  child: const Text('TRAZAR RUTA'),
                ),
                const Spacer(),
                ElevatedButton( key: const Key("create_button"),
                  onPressed: () {
                    if (_segmentNameController.text.isNotEmpty &&
                        _startController.text.isNotEmpty &&
                        _endController.text.isNotEmpty) {
                      _segmentController.addSegment(_segmentNameController.text,
                          _startController.text, _endController.text);
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
