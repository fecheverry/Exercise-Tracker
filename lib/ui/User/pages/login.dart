import 'package:exercise_tracker/ui/User/controllers/user_controller.dart';
import 'package:exercise_tracker/ui/User/pages/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  final UserController _userController = Get.find();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  LoginView({super.key});

  Future<Position> _getCurrentLocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Por favor active la ubicacion');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Para usar la aplicacion tienes que aceptar permisos de ubicacion');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LOG IN',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _userController.login(
                      _emailController.text, _passwordController.text);
                },
                child: const Text('LOG IN'),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  // Aquí puedes agregar la lógica para redirigir al usuario a la pantalla de registro
                },
                child: RichText(
                  text: TextSpan(
                    text: '¿No tienes una cuenta? ',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                    children: [
                      TextSpan(
                        text: 'Regístrate',
                        style: TextStyle(
                          color: Colors.amber[400],
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => RegisterView());
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
