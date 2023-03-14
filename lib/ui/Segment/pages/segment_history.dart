import 'package:exercise_tracker/ui/Activity/pages/home.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_create.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Activity/pages/activity_history.dart';
import '../../User/controllers/user_controller.dart';

class SegmentHistoryView extends StatefulWidget {
  const SegmentHistoryView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SegmentHistoryViewState createState() => _SegmentHistoryViewState();
}

class _SegmentHistoryViewState extends State<SegmentHistoryView> {
  final UserController _userController = Get.find();
  final List<Segmento> _segmentos = [
    Segmento(
      name: "SEGMENTO 1",
      start: "CRA 1",
      end: "CRA 2",
    ),
    Segmento(
      name: "SEGMENTO 2",
      start: "CRA 1",
      end: "CRA 2",
    ),
    Segmento(
      name: "SEGMENTO 3",
      start: "CRA 1",
      end: "CRA 2",
    ),
    Segmento(
      name: "SEGMENTO 1",
      start: "CRA 1",
      end: "CRA 2",
    ),
    Segmento(
      name: "SEGMENTO 2",
      start: "CRA 1",
      end: "CRA 2",
    ),
    Segmento(
      name: "SEGMENTO 3",
      start: "CRA 1",
      end: "CRA 2",
    ),
    Segmento(
      name: "SEGMENTO 1",
      start: "CRA 1",
      end: "CRA 2",
    ),
    Segmento(
      name: "SEGMENTO 2",
      start: "CRA 1",
      end: "CRA 2",
    ),
    Segmento(
      name: "SEGMENTO 3",
      start: "CRA 1",
      end: "CRA 2",
    ),
    Segmento(
      name: "SEGMENTO 1",
      start: "CRA 1",
      end: "CRA 2",
    ),
    Segmento(
      name: "SEGMENTO 2",
      start: "CRA 1",
      end: "CRA 2",
    ),
    Segmento(
      name: "SEGMENTO 3",
      start: "CRA 1",
      end: "CRA 2",
    ),
  ];

  bool _visible = true;

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
          onPressed: () {
            Get.to(() => HomeView());
          },
        ),
        title: const Text(
          'SEGMENTOS',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: ListView.separated(
        itemCount: _segmentos.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          final segmento = _segmentos[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                _segmentos.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("segmento eliminado"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(segmento.name),
              subtitle: Text(
                'Empieza en: ${segmento.start} \nTermina en: ${segmento.end}',
              ),
              onTap: () {
                _visible = !_visible;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SegmentDetailView(),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => SegmentCreationView());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue, // color de fondo del BottomNavigationBar
        selectedItemColor: Colors.amber, // color de los elementos seleccionados
        unselectedItemColor: Colors.grey,

        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Get.to(() => const ActivityHistoryView());
          }
          if (index == 1) {
            Get.to(() => HomeView());
          }
          if (index == 3) {
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}

class Segmento {
  final String name;
  final String start;
  final String end;

  Segmento({required this.name, required this.start, required this.end});
}
