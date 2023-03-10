import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityDetailView extends StatelessWidget {

  const ActivityDetailView({
    super.key,
  });

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
        // ignore: prefer_const_constructors
        title: Text(
          "TROTE",
          style: const TextStyle(color: Colors.amber),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    "00.00.00",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Duracion",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 150,
              ),
              Column(
                children: const [
                  Text(
                    "0.00",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Recorrido",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
