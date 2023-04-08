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

  group("Segments", () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets("Segment History", (tester) async {
      Widget w = await createLoginScreen();
      await tester.pumpWidget(w);

      // Enter  credentials
      await tester.enterText(
          find.byKey(const Key('email_input')), 'luis@gmail.com');
      await tester.enterText(
          find.byKey(const Key('password_input')), 'luis123');

      // Tap the login button
      await tester.tap(find.widgetWithText(ElevatedButton, 'LOG IN'));
      await tester.pumpAndSettle();

      final Finder segmentosButton = find.text('Segmentos');

      // Simula el toque en el botón de "Segmentos"
      await tester.tap(segmentosButton);

      // Espera a que la pantalla se actualice con el nuevo widget
      await tester.pumpAndSettle();

      expect(find.text("SEGMENTOS"), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(1));
      await tester.tap(find.byKey(const Key("add_button")));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key('name_input')), "name");
      await tester.enterText(find.byKey(const Key('start_input')), "start");
      await tester.enterText(find.byKey(const Key('end_input')), "end");

      await tester.tap(find.byKey(const Key("create_button")));
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsNWidgets(2));

      await tester.tap(find.byKey(const Key("public_button")));
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsNWidgets(1));
      expect(find.text("name"), findsOneWidget);
      expect(find.text("EMPIEZA EN: start"), findsOneWidget);
      expect(find.text("TERMINA EN: end"), findsOneWidget);

      await tester.tap(find.byKey(const Key("public_button")));
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsNWidgets(2));
    });
  });
}
