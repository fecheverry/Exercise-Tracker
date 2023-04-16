import 'package:exercise_tracker/ui/Activity/controllers/activity_controller.dart';
import 'package:exercise_tracker/ui/Activity/models/activity_model.dart';
import 'package:exercise_tracker/ui/Activity/pages/activity_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';

class MockActivityController extends GetxService
    with Mock
    implements ActivityController {
  final List<Activity> _activities = [
    Activity(
        id: "1",
        idUser: "2",
        duration: "00:00:00",
        distance: "00.0",
        date: "2022-04-16 16:30:00",
        type: "TROTE",
        segments: [],
        points: [])
  ].obs;

  @override
  void addActivity(String duration, String distance, String date, String type,
      List<TimeSegment> segments, List<LatLng> points) {
    Activity activityToAdd = Activity(
        id: (_activities.length + 2).toString(),
        idUser: "2",
        duration: duration,
        distance: distance,
        date: date,
        type: type,
        segments: segments,
        points: points);
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

    //Se verifica que se esten mostrando los elementos que deben ir en esta vista
    expect(find.widgetWithText(AppBar, "ACTIVIDADES"), findsOneWidget);
    expect(find.byIcon(Icons.directions_run), findsOneWidget);
    expect(find.byIcon(Icons.watch_later), findsOneWidget);
    expect(find.byIcon(Icons.segment), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);

    //Se agrega una actividad manualmente y se verifica que se este mostrando en la vista
    mockActivityController.addActivity("01", "", "2023-04-16 16:30:00", "", [], []);
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNWidgets(2));

    //Se Toma la primera carta  y se desliza hacia la izquierda para eliminarla, luego se verifica que si se haya eliminado
    final cardFinder = find.byType(Card).first;
    await tester.drag(cardFinder, const Offset(-500.0, 0.0));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsOneWidget);

    Get.delete<ActivityController>();
  });
}
