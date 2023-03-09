import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetalleSegmentoView(segmento: segmento),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción del botón flotante
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class DetalleSegmentoView extends StatelessWidget {
  final Segmento segmento;

  const DetalleSegmentoView({Key? key, required this.segmento})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle actividad'),
      ),
      body: Center(
        child: Text(
          'Nombre: ${segmento.name}\nInicia en: ${segmento.start}\nTermina en: ${segmento.end}',
        ),
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
