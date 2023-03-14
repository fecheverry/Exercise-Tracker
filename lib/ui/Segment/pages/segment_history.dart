import 'package:exercise_tracker/ui/Activity/pages/home.dart';
import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_create.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/segment_model.dart';

import '../../Activity/pages/activity_history.dart';
import '../../User/controllers/user_controller.dart';

class SegmentHistoryView extends StatefulWidget {
  const SegmentHistoryView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SegmentHistoryViewState createState() => _SegmentHistoryViewState();
}

class _SegmentHistoryViewState extends State<SegmentHistoryView> {
  bool _myList = false;
  final UserController _userController = Get.find();
  final SegmentController _segmentController = Get.find();

  void _changeList() {
    setState(() {
      _myList = !_myList;
    });
  }

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
      body: _myList
          ? ListView.separated(
              itemCount: _segmentController.mySegments.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                final segmento = _segmentController.mySegments[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      _segmentController.mySegments.removeAt(index);
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
            )
          : ListView.separated(
              itemCount: _segmentController.allSegments.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                final segmento = _segmentController.allSegments[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      _segmentController.allSegments.removeAt(index);
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
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 60,
            right: 0,
            child: FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                _changeList();
              },
              child: _myList
                  ? const Icon(Icons.public)
                  : const Icon(Icons.public_off),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                Get.to(() => SegmentCreationView());
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
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
