import 'package:exercise_tracker/ui/Activity/controllers/activity_controller.dart';
import 'package:exercise_tracker/ui/Activity/models/activity_model.dart';
import 'package:exercise_tracker/ui/Activity/pages/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class MockActivityController extends GetxService
    with Mock
    implements ActivityController {
  final List<Activity> _activities = [];

  @override
  void addActivity(String duration, String distance, String date, String type,
      List<TimeSegment> segments) {
    Activity activityToAdd = Activity(
        id: (_activities.length + 1).toString(),
        idUser: "1",
        duration: duration,
        distance: distance,
        date: date,
        type: type,
        segments: segments);
    _activities.add(activityToAdd);
  }
@override
  List<Activity> get listActivities => _activities;
}

void main() {
  setUp(() {});
  testWidgets('Create Activity Test', (WidgetTester tester) async {
    // aquí instanciamos el mock controller
    MockActivityController mockActivityController = MockActivityController();
    // lo pasamos al DI de Get
    Get.put<ActivityController>(mockActivityController);
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: ActivityView(
        type: "TROTE",
      ),
    )));
    await tester.pump();

    final finalizar = find.widgetWithText(SizedBox, 'FINALIZAR');
    final pausar = find.widgetWithText(SizedBox, 'PAUSAR');
    
    //Se verifica que se esten mostrando los elementos que deben ir en esta vista
    expect(finalizar, findsOneWidget);
    expect(pausar, findsOneWidget);
    expect(find.text('Duracion'), findsOneWidget);
    expect(find.text('Distancia'), findsOneWidget);

    //Se presiona el boton de pausar y se verifica que el boton cambie de "PAUSAR" a "CONTINUAR"
    await tester.tap(pausar);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(SizedBox, 'CONTINUAR'), findsOneWidget);

    //Se Finaliza la actividad y se verifica que se haya agregado a la lista de actividades
    await tester.tap(finalizar);
    await tester.pumpAndSettle();
    expect(mockActivityController.listActivities.length, 1);

     Get.delete<ActivityController>();
  });
}
