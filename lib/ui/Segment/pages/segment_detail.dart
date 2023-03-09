import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SegmentDetailView extends StatelessWidget {
  final String segmentName;
  final String bestTime;
  final String avgTime;
  final String start;
  final String end;

  SegmentDetailView({
    super.key,
    required this.segmentName,
    required this.bestTime,
    required this.avgTime,
    required this.start,
    required this.end,
  });

  final List<Map<String, String>> _rankingData = [
    {"rank": "1", "name": "John Doe", "time": "2:45:12"},
    {"rank": "2", "name": "Jane Smith", "time": "3:01:45"},
    {"rank": "3", "name": "Bob Johnson", "time": "3:05:22"},
    {"rank": "4", "name": "Emily Brown", "time": "3:10:11"},
    {"rank": "5", "name": "Mike Wilson", "time": "3:15:00"},
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
        title: Text(
          segmentName,
          style: const TextStyle(color: Colors.amber),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            bestTime,
                            style: const TextStyle(fontSize: 24.0),
                          ),
                          const Text(
                            'Mejor tiempo',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            avgTime,
                            style: const TextStyle(fontSize: 24.0),
                          ),
                          const Text(
                            'Tiempo promedio',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Row(
                    children: [
                      Icon(
                        Icons.control_point,
                        color: Colors.amber[400],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        start,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Icon(
                        Icons.control_point,
                        color: Colors.amber[400],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        end,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Ranking:',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            DataTable(
              columns: const [
                DataColumn(label: Text('Pos.')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Tiempo')),
              ],
              rows: _rankingData
                  .map(
                    (data) => DataRow(
                      cells: [
                        DataCell(Text(data['rank']!)),
                        DataCell(Text(data['name']!)),
                        DataCell(Text(data['time']!)),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Agregar acción aquí
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
