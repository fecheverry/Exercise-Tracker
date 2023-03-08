import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration:  InputDecoration(
                    labelText: 'Correo electrónico',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  obscureText: true,
                  decoration:  InputDecoration(
                    labelText: 'Contraseña',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes agregar la lógica para hacer el inicio de sesión
                  // utilizando los valores de los controladores emailController y passwordController
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
