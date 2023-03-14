import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/activity_model.dart';

class ActivityDetailView extends StatelessWidget {
  final Activity actividad;

  // ignore: empty_constructor_bodies
  ActivityDetailView({super.key, required this.actividad}) {}

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
          actividad.type,
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
                      actividad.duration,
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
                      actividad.distance,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 1,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 60,
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
                itemCount: actividad.segments.length,
                itemBuilder: (context, index) {
                  final segmento = actividad.segments[index];
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
