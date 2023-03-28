import 'package:exercise_tracker/ui/Activity/controllers/activity_controller.dart';
import 'package:exercise_tracker/ui/Activity/models/activity_model.dart';
import 'package:exercise_tracker/ui/Activity/pages/activity_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class MockActivityController extends GetxService
    with Mock
    implements ActivityController {
  final List<Activity> _activities = [
    Activity(
        id: "1",
        idUser: "1",
        duration: "00:00:00",
        distance: "00.0",
        date: "date",
        type: "TROTE",
        segments: [])
  ].obs;

  @override
  void addActivity(String duration, String distance, String date, String type,
      List<TimeSegment> segments) {
    Activity activityToAdd = Activity(
        id: (_activities.length + 2).toString(),
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
  @override
  void removeAvtivity(int index) {
    _activities.removeWhere((elemento) => elemento == listActivities[index]);
  }
}

void main() {
  setUp(() {});
  testWidgets('List Activity Test', (WidgetTester tester) async {
    // aquí instanciamos el mock controller
    MockActivityController mockActivityController = MockActivityController();
    // lo pasamos al DI de Get
    Get.put<ActivityController>(mockActivityController);
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
      body: ActivityHistoryView(),
    )));
    await tester.pump();

    expect(find.widgetWithText(AppBar, "ACTIVIDADES"), findsOneWidget);
    expect(find.byIcon(Icons.directions_run), findsOneWidget);
    expect(find.byIcon(Icons.watch_later), findsOneWidget);
    expect(find.byIcon(Icons.segment), findsOneWidget);

    expect(find.byType(Card), findsOneWidget);
    mockActivityController.addActivity("01", "", "", "", []);
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNWidgets(2));

    final cardFinder = find.byType(Card).first;

    // arrastra la tarjeta hacia la izquierda
    await tester.drag(cardFinder, const Offset(-500.0, 0.0));
    await tester.pumpAndSettle();

    // verifica que la tarjeta se ha eliminado
    expect(find.byType(Card), findsOneWidget);

    Get.delete<ActivityController>();
  });
}
