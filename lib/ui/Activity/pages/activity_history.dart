import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'activity_detail.dart';

class ActivityHistoryView extends StatefulWidget {
  const ActivityHistoryView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ActivityHistoryViewState createState() => _ActivityHistoryViewState();
}

class _ActivityHistoryViewState extends State<ActivityHistoryView> {
  final List<Actividad> _actividades = [
    Actividad(
      fecha: DateTime.now(),
      duracion: const Duration(hours: 1, minutes: 30, seconds: 45),
      recorrido: "10.5",
    ),
    Actividad(
      fecha: DateTime.now().subtract(const Duration(days: 1)),
      duracion: const Duration(hours: 2, minutes: 0, seconds: 15),
      recorrido: "7.2",
    ),
    Actividad(
      fecha: DateTime.now().subtract(const Duration(days: 2)),
      duracion: const Duration(hours: 0, minutes: 45, seconds: 20),
      recorrido: "3.1",
    ),
    Actividad(
      fecha: DateTime.now(),
      duracion: const Duration(hours: 1, minutes: 30, seconds: 45),
      recorrido: "10.5",
    ),
    Actividad(
      fecha: DateTime.now().subtract(const Duration(days: 1)),
      duracion: const Duration(hours: 2, minutes: 0, seconds: 15),
      recorrido: "7.2",
    ),
    Actividad(
      fecha: DateTime.now().subtract(const Duration(days: 2)),
      duracion: const Duration(hours: 0, minutes: 45, seconds: 20),
      recorrido: "3.1",
    ),
    Actividad(
      fecha: DateTime.now(),
      duracion: const Duration(hours: 1, minutes: 30, seconds: 45),
      recorrido: "10.5",
    ),
    Actividad(
      fecha: DateTime.now().subtract(const Duration(days: 1)),
      duracion: const Duration(hours: 2, minutes: 0, seconds: 15),
      recorrido: "7.2",
    ),
    Actividad(
      fecha: DateTime.now().subtract(const Duration(days: 2)),
      duracion: const Duration(hours: 0, minutes: 45, seconds: 20),
      recorrido: "3.1",
    ),
    Actividad(
      fecha: DateTime.now(),
      duracion: const Duration(hours: 1, minutes: 30, seconds: 45),
      recorrido: "10.5",
    ),
    Actividad(
      fecha: DateTime.now().subtract(const Duration(days: 1)),
      duracion: const Duration(hours: 2, minutes: 0, seconds: 15),
      recorrido: "7.2",
    ),
    Actividad(
      fecha: DateTime.now().subtract(const Duration(days: 2)),
      duracion: const Duration(hours: 0, minutes: 45, seconds: 20),
      recorrido: "3.1",
    ),
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
        title: const Text(
          'ACTIVIDADES',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: ListView.separated(
        itemCount: _actividades.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          final actividad = _actividades[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                _actividades.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Actividad eliminada"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(actividad.fecha.toString()),
              subtitle: Text(
                'Duración: ${actividad.duracion.inHours}h ${actividad.duracion.inMinutes % 60}m ${actividad.duracion.inSeconds % 60}s, \nRecorrido: ${actividad.recorrido}',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityDetailView(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Actividad {
  final DateTime fecha;
  final Duration duracion;
  final String recorrido;

  Actividad(
      {required this.fecha, required this.duracion, required this.recorrido});
}
