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

  group("Activity", () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets("Activity History", (tester) async {
      Widget w = await createLoginScreen();
      await tester.pumpWidget(w);

      // Enter incorrect credentials
      await tester.enterText(
          find.byKey(const Key('email_input')), 'fabian@gmail.com');
      await tester.enterText(
          find.byKey(const Key('password_input')), 'fabian123');

      // Tap the login button
      await tester.tap(find.widgetWithText(ElevatedButton, 'LOG IN'));
      await tester.pumpAndSettle();

      final Finder actividadesButton = find.text('Actividades');

      // Simula el toque en el botón de "Actividades"
      await tester.tap(actividadesButton);

      // Espera a que la pantalla se actualice con el nuevo widget
      await tester.pumpAndSettle();

      expect(find.text("date"), findsOneWidget);
      expect(find.text("00:00:00"), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });
  });
}
