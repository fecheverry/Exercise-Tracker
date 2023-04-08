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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0, //remover sombra

        title: const Text(
          'SEGMENTOS',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: _myList
          ? Obx(() => ListView.builder(
                itemCount: _segmentController.mySegments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key(_segmentController.mySegments[index].name),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        _segmentController.removeSegment(
                            _segmentController.mySegments[index]);
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
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: ListTile(
                          title: Text(
                            _segmentController.mySegments[index].name,
                            textAlign: TextAlign.start,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "EMPIEZA EN: ${_segmentController.mySegments[index].start}",
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                "TERMINA EN: ${_segmentController.mySegments[index].end}",
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                            MaterialPageRoute(
                              builder: (context) => SegmentDetailView(
                                  segmento:  _segmentController.mySegments[index]),
                            ),
                          );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ))
          : Obx(() => ListView.builder(
                itemCount: _segmentController.allSegments.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: ListTile(
                        title: Text(
                          _segmentController.allSegments[index].name,
                          textAlign: TextAlign.start,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "EMPIEZA EN: ${_segmentController.allSegments[index].start}",
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "TERMINA EN: ${_segmentController.allSegments[index].end}",
                              textAlign: TextAlign.start,
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SegmentDetailView(
                                  segmento:  _segmentController.allSegments[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              )),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 60,
            right: 0,
            child: FloatingActionButton(               key: const Key("public_button"),
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
              key: const Key("add_button"),
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
        backgroundColor: Colors.white, // color de fondo del BottomNavigationBar
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
