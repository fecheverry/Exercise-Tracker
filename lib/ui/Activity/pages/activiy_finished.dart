import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivyFinishedView extends StatelessWidget {
  final List<Map<String, String>> segmentos = [
    {
      'nombre': 'Segmento 1',
      'tiempo': '1:23',
      'ranking': '1° de 10',
    },
    {
      'nombre': 'Segmento 2',
      'tiempo': '2:45',
      'ranking': '3° de 12',
    },
    {
      'nombre': 'Segmento 3',
      'tiempo': '0:59',
      'ranking': '5° de 8',
    },
    {
      'nombre': 'Segmento 4',
      'tiempo': '1:36',
      'ranking': '2° de 6',
    },
    {
      'nombre': 'Segmento 5',
      'tiempo': '2:12',
      'ranking': '4° de 9',
    },
    {
      'nombre': 'Segmento 1',
      'tiempo': '1:23',
      'ranking': '1° de 10',
    },
    {
      'nombre': 'Segmento 2',
      'tiempo': '2:45',
      'ranking': '3° de 12',
    },
    {
      'nombre': 'Segmento 3',
      'tiempo': '0:59',
      'ranking': '5° de 8',
    },
    {
      'nombre': 'Segmento 4',
      'tiempo': '1:36',
      'ranking': '2° de 6',
    },
    {
      'nombre': 'Segmento 5',
      'tiempo': '2:12',
      'ranking': '4° de 9',
    },
    {
      'nombre': 'Segmento 1',
      'tiempo': '1:23',
      'ranking': '1° de 10',
    },
    {
      'nombre': 'Segmento 2',
      'tiempo': '2:45',
      'ranking': '3° de 12',
    },
    {
      'nombre': 'Segmento 3',
      'tiempo': '0:59',
      'ranking': '5° de 8',
    },
    {
      'nombre': 'Segmento 4',
      'tiempo': '1:36',
      'ranking': '2° de 6',
    },
    {
      'nombre': 'Segmento 5',
      'tiempo': '2:12',
      'ranking': '4° de 9',
    },
  ];
  final String tipoActividad;
  final String duracion;

  ActivyFinishedView({
    super.key,
    required this.tipoActividad,
    required this.duracion,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, //remover sombra
        leading: IconButton(
          icon: const Icon(Icons.save_alt),
          color: Colors.amber[400],
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'GUARDAR',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Duracion",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const Spacer(),
                Text(
                  duracion,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Text(
                  "Distancia",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Spacer(),
                Text(
                  "0.00",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 1,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'SEGMENTOS',
                    style: TextStyle(
                      color: Colors.amber[400],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 1,
                  color: Colors.grey,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: segmentos.length,
                itemBuilder: (context, index) {
                  final segmento = segmentos[index];
                  return ListTile(
                    title: Text(segmento['nombre']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tiempo: ${segmento['tiempo']}'),
                        Text('Ranking: ${segmento['ranking']}'),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
