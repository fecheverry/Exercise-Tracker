import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Segment/pages/segment_history.dart';
import '../controllers/activity_controller.dart';
import 'activity_detail.dart';
import 'home.dart';

class ActivityHistoryView extends StatefulWidget {
  const ActivityHistoryView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ActivityHistoryViewState createState() => _ActivityHistoryViewState();
}

class _ActivityHistoryViewState extends State<ActivityHistoryView> {
  final ActivityController _activityController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0, //remover sombra
        title: const Text(
          'ACTIVIDADES',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Obx(() => ListView.builder(
            itemCount: _activityController.listActivities.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(_activityController.listActivities[index].date),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    _activityController.removeAvtivity(index);
                  });
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Card(
                  key: Key(_activityController.listActivities[index].date),
                  child: ListTile(
                    title: Text(_activityController.listActivities[index].date),
                    subtitle: Text(
                        _activityController.listActivities[index].duration),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityDetailView(
                              actividad:
                                  _activityController.listActivities[index]),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // color de fondo del BottomNavigationBar
        selectedItemColor: Colors.amber, // color de los elementos seleccionados
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Get.to(() => HomeView());
          }
          if (index == 2) {
            Get.to(() => const SegmentHistoryView());
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              key: Key("activity_button"),
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
