import 'package:exercise_tracker/ui/Activity/models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Segment/pages/segment_history.dart';
import '../../User/controllers/user_controller.dart';
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
  final UserController _userController = Get.find();
  final ActivityController _activityController = Get.find();

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
          'ACTIVIDADES',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: ListView.separated(
        itemCount: _activityController.listActivities.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          final actividad = _activityController.listActivities[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                _activityController.listActivities.removeAt(index);
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
              title: Text(actividad.date),
              subtitle: Text(
                'Duración: ${actividad.duration}',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ActivityDetailView(actividad: actividad),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
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
