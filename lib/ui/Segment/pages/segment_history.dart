import 'package:exercise_tracker/ui/Activity/pages/home.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_create.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Activity/pages/activity_history.dart';

class SegmentHistoryView extends StatefulWidget {
  const SegmentHistoryView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SegmentHistoryViewState createState() => _SegmentHistoryViewState();
}

class _SegmentHistoryViewState extends State<SegmentHistoryView> {
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
            Get.to(() => const HomeView());
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
                  Get.to(() =>  SegmentCreationView());
                },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Get.to(() => const ActivityHistoryView());
          }
          if (index == 1) {
            Get.to(() => const HomeView());
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

class Segmento {
  final String name;
  final String start;
  final String end;

  Segmento({required this.name, required this.start, required this.end});
}
