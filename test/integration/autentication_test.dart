import 'package:exercise_tracker/ui/Activity/controllers/activity_controller.dart';
import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:exercise_tracker/ui/User/controllers/user_controller.dart';
import 'package:exercise_tracker/ui/User/pages/login.dart';
import 'package:exercise_tracker/ui/my_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:integration_test/integration_test_driver.dart';
import 'package:integration_test/integration_test.dart';

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
  group("Autentication", () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets("Login whit incorrect user", (tester) async {
      Widget w = await createLoginScreen();
      await tester.pumpWidget(w);

      await tester.tap(find.text("LOG IN"));
      await tester.pumpAndSettle(Duration(seconds: 5));
    });
  });
}
