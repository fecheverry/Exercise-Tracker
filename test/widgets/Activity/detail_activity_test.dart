import 'package:exercise_tracker/ui/Activity/controllers/activity_controller.dart';
import 'package:exercise_tracker/ui/Activity/models/activity_model.dart';
import 'package:exercise_tracker/ui/Activity/pages/activity_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class MockActivityController extends GetxService
    with Mock
    implements ActivityController {}

void main() {
  setUp(() {});
  testWidgets('Detail Activity Test', (WidgetTester tester) async {
    // aquí instanciamos el mock controller
    MockActivityController mockActivityController = MockActivityController();
    // lo pasamos al DI de Get
    Get.put<ActivityController>(mockActivityController);
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: ActivityDetailView(
          actividad: Activity(
              id: "1",
              idUser: "1",
              duration: "00:00:01",
              distance: "00.01",
              date: "",
              type: "TIPO",
              segments: [
            TimeSegment(
                idSegment: "00",
                time: "00:00:00",
                segmentName: "LA 59")
          ],
          points: [])),
    )));
    await tester.pump();

    //Se verifica que se esten mostrando los elementos que deben ir en esta vista
    expect(find.widgetWithText(AppBar, "TIPO"), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsOneWidget);
    expect(find.text('Duracion'), findsOneWidget);
    expect(find.text('Recorrido'), findsOneWidget);
    expect(find.text("00:00:01"), findsOneWidget);
    expect(find.text("00.01"), findsOneWidget);
    expect(find.text("SEGMENTOS"), findsOneWidget);
    expect(find.text("LA 59"), findsOneWidget);
    expect(find.text("Tiempo: 00:00:00"), findsOneWidget);

    Get.delete<ActivityController>();
  });
}
