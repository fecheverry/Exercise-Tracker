import 'package:exercise_tracker/ui/Activity/controllers/activity_controller.dart';
import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:exercise_tracker/ui/User/controllers/user_controller.dart';
import 'package:exercise_tracker/ui/User/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Widget> createLoginScreen() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController());
  Get.put(ActivityController());
  Get.put(SegmentController());
  return GetMaterialApp(
    home: LoginView(),
  );
}

void main() {
  setUpAll(() async {
    await Permission.location.request();
  });

  group("Autentication", () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets("Login with incorrect user", (tester) async {
      Widget w = await createLoginScreen();
      await tester.pumpWidget(w);

      // Enter incorrect credentials
      await tester.enterText(
          find.byKey(const Key('email_input')), 'correo@gmail.com');
      await tester.enterText(
          find.byKey(const Key('password_input')), 'contraseña');

      // Tap the login button
      await tester.tap(find.widgetWithText(ElevatedButton, 'LOG IN'));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verify that an error message is displayed
      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets("Creation", (WidgetTester tester) async {
      Widget w = await createLoginScreen();
      await tester.pumpWidget(w);

      // 1. Click en el textSpan "Regístrate"
      await tester.tap(find.byKey(const Key("registrarse_button")));
      await tester.pumpAndSettle();

      // 2. Ingresa el string "nombre" en el TextFormField que dice "Nombre"
      await tester.enterText(
          find.byKey(const Key("nombre_text_field")), "nombre");
      await tester.pumpAndSettle();

      // 3. Ingresa el string "apellido" en el TextFormField que dice "Apellido"
      await tester.enterText(
          find.byKey(const Key("apellido_text_field")), "apellido");
      await tester.pumpAndSettle();

      // 4. Ingresa el string "correo" en el TextFormField que dice "Correo"
      await tester.enterText(
          find.byKey(const Key("correo_text_field")), "correo@gmail.com");
      await tester.pumpAndSettle();

      // 5. Ingresa el string "contraseña" en el TextFormField que dice "Contraseña"
      await tester.enterText(
          find.byKey(const Key("contraseña_text_field")), "contraseña");
      await tester.pumpAndSettle();

      // 6. Click en el botón que dice "CREAR CUENTA"
      await tester.tap(find.byKey(const Key("crear_cuenta_button")));
      await tester.pumpAndSettle();

      // 7. Espera encontrar un texto que diga "Bienvenido, nombre"
      expect(find.text("Bienvenido, nombre"), findsOneWidget);
    });
     testWidgets("Login", (tester) async {
      Widget w = await createLoginScreen();
      await tester.pumpWidget(w);

      // Enter incorrect credentials
      await tester.enterText(
          find.byKey(const Key('email_input')), 'fabian@gmail.com');
      await tester.enterText(
          find.byKey(const Key('password_input')), 'fabian123');

      // Tap the login button
      await tester.tap(find.widgetWithText(ElevatedButton, 'LOG IN'));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verify that an error message is displayed
      expect(find.text('Bienvenido, Fabian'), findsOneWidget);
    });
  });
}
