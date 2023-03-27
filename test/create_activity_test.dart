import 'package:exercise_tracker/ui/Activity/controllers/activity_controller.dart';
import 'package:exercise_tracker/ui/Activity/pages/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class ActivityControllerMock extends Mock implements ActivityController {}

void main() {
  bool sw = false;
  testWidgets('Test Activity View', (WidgetTester tester) async {
    // Crea el controlador de actividades mock
    final activityControllerMock = ActivityControllerMock();
    when(activityControllerMock.addActivity("", "", "", "", []))
        .thenAnswer((_) {});
    // Registra el controlador mock en GetX
    Get.put<ActivityController>(activityControllerMock);

    // Crea la vista que contiene el botón
    await tester.pumpWidget(
      GetMaterialApp(
        home: ActivityView(
          type: "TROTE",
        ),
      ),
    );

    // Encuentra el botón en la vista y lo toca
    final finder = find.widgetWithText(SizedBox, 'FINALIZAR');
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();

    // Verifica que se haya llamado el método addActivity en el controlador
    verify(activityControllerMock.addActivity("", "", "", "", [])).called(1);
  });
}
