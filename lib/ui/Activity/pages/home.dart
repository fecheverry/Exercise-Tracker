import 'package:exercise_tracker/ui/Activity/pages/activity_history.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../User/controllers/user_controller.dart';
import 'activity.dart';

class HomeView extends StatelessWidget {
  final UserController _userController = Get.find();

  HomeView({super.key}); // Aquí debes insertar el nombre del usuario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('¿Está seguro desea cerrar la sesion?'),
                      actions: [
                        TextButton(
                          child: const Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Sí'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            _userController.logout();
                          },
                        ),
                      ],
                    );
                  });
            },
            icon: Icon(
              Icons.logout,
              color: Colors.amber,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Bienvenido, ${_userController.userInfo!.name}",
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityView(type: "BICICLETA"),
                    ),
                  );
                },
                icon: const Icon(Icons.directions_bike),
                color: Colors.amber, // cambia el color del icono
                iconSize: 60, // cambia el tamaño del icono
              ),
              const SizedBox(width: 120),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityView(type: "TROTE"),
                    ),
                  );
                },
                icon: const Icon(Icons.directions_run),
                color: Colors.amber, // cambia el color del icono
                iconSize: 60, // cambia el tamaño del icono
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // color de fondo del BottomNavigationBar
        selectedItemColor: Colors.amber, // color de los elementos seleccionados
        unselectedItemColor: Colors.grey,
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
            label: "Actividades",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: "Iniciar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.segment),
            label: "Segmentos",
          ),
        ],
      ),
    );
  }
}
