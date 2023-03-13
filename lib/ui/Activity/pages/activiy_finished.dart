import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/activity_model.dart';
import 'activity_history.dart';

class ActivityFinishedView extends StatelessWidget {
  final Activity activity;
  const ActivityFinishedView({super.key, required this.activity});

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
        padding: const EdgeInsets.only(left: 20.0),
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
                  activity.duration,
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
              children:  [
                Text(
                  activity.distance,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                const Spacer(),
                const Text(
                  "0.00",
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 1,
                  color: Colors.grey,
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
                  width: 30,
                  height: 1,
                  color: Colors.grey,
                ),
              ],
            ),
            /*Expanded(
              child: ListView.builder(
                itemCount: segmentos.length,
                itemBuilder: (context, index) {
                  final segmento = segmentos[index];
                  return ListTile(
                    title: Text(segmento['nombre']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tiempo: ${segmento['tiempo']}'),
                        Text('Ranking: ${segmento['ranking']}'),
                      ],
                    ),
                  );
                },
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
