import 'package:exercise_tracker/ui/Activity/pages/activity_history.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'activity.dart';

class HomeView extends StatelessWidget {
  final String userName = "Juan";

  const HomeView({super.key}); // Aquí debes insertar el nombre del usuario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Bienvenido, $userName",
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 100),
          const Text(
            "¿Qué actividad deseas realizar hoy?",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => const ActivityView());
                },
                icon: const Icon(Icons.directions_bike),
                color: Colors.amber, // cambia el color del icono
                iconSize: 60, // cambia el tamaño del icono
              ),
              const SizedBox(width: 120),
              IconButton(
                onPressed: () {
                  Get.to(() => const ActivityView());
                },
                icon: const Icon(Icons.directions_run),
                color: Colors.amber, // cambia el color del icono
                iconSize: 60, // cambia el tamaño del icono
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar( backgroundColor: Colors.white,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
              Get.to(() => const ActivityHistoryView());
          }
          if (index == 2) {
              Get.to(() => const SegmentHistoryView());
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_run,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.segment),
            label: "",
          ),
        ],
      ),
    );
  }
}
