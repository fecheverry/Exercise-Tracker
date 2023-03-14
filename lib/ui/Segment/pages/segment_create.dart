import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SegmentCreationView extends StatelessWidget {
  SegmentController _segmentController = Get.find();

  final TextEditingController _segmentNameController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  SegmentCreationView({super.key});

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
        title: const Text(
          'REGISTRO',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _segmentNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del segmento',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _startController,
              decoration: const InputDecoration(
                labelText: 'Inicio',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _endController,
              decoration: const InputDecoration(
                labelText: 'Fin',
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _segmentController.addSegment(_segmentNameController.text, _startController.text, _endController.text);
              },
              child: const Text('CREAR SEGMENTO'),
            ),
          ],
        ),
      ),
    );
  }
}
