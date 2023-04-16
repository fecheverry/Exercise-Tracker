import 'package:exercise_tracker/ui/Activity/controllers/activity_controller.dart';
import 'package:exercise_tracker/ui/Activity/models/activity_model.dart';
import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:exercise_tracker/ui/Segment/models/segment_model.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:time_machine/time_machine.dart';

class MockSegmentController extends GetxService
    with Mock
    implements SegmentController {
  final ActivityController _activityController = Get.find();

  @override
  String timeBetter(String id) {
    List<TimeSegment> myactinsegment = [];
    for (Activity act in _activityController.listActivities) {
      for (TimeSegment i in act.segments) {
        if (i.idSegment == id) {
          myactinsegment.add(i);
        }
      }
    }
    if (myactinsegment.isEmpty) {
      return "00:00:00";
    } else {
      myactinsegment.sort((a, b) => a.time.compareTo(b.time));
      return myactinsegment.first.time;
    }
  }

  @override
  String averageTime(String id) {
    List<Time> times = [];
    final formatoTiempo = DateFormat("HH:mm:ss");
    for (Activity act in _activityController.listActivities) {
      for (TimeSegment i in act.segments) {
        if (i.idSegment == id) {
          final tiempo = formatoTiempo.parse(i.time);
          times.add(Time(
              hours: tiempo.hour,
              minutes: tiempo.minute,
              seconds: tiempo.second.toInt()));
        }
      }
    }
    if (times.isEmpty) {
      return "00:00:00";
    } else {
      Time avarage = Time(hours: 00, minutes: 00, seconds: 00);
      for (Time i in times) {
        avarage += i;
      }
      return (avarage / times.length).toString().substring(2);
    }
  }

  @override
  List<Map<String, String>> ranking(String id) {
    return [
      {"rank": "1", "name": "John Doe", "time": "2:45:12"},
      {"rank": "2", "name": "Jane Smith", "time": "3:01:45"},
      {"rank": "3", "name": "Bob Johnson", "time": "3:05:22"},
      {"rank": "4", "name": "Emily Brown", "time": "3:10:11"},
      {"rank": "5", "name": "Mike Wilson", "time": "3:15:00"},
      {"rank": "1", "name": "John Doe", "time": "2:45:12"},
      {"rank": "2", "name": "Jane Smith", "time": "3:01:45"},
      {"rank": "3", "name": "Bob Johnson", "time": "3:05:22"},
      {"rank": "4", "name": "Emily Brown", "time": "3:10:11"},
      {"rank": "5", "name": "Mike Wilson", "time": "3:15:00"},
      {"rank": "1", "name": "John Doe", "time": "2:45:12"},
      {"rank": "2", "name": "Jane Smith", "time": "3:01:45"},
      {"rank": "3", "name": "Bob Johnson", "time": "3:05:22"},
      {"rank": "4", "name": "Emily Brown", "time": "3:10:11"},
      {"rank": "5", "name": "Mike Wilson", "time": "3:15:00"},
    ];
  }
}

class MockActivityController extends GetxService
    with Mock
    implements ActivityController {
  final List<Activity> _activities = [];

  @override
  List<Activity> get listActivities => List<Activity>.from(
      _activities.where((element) => element.idUser == "2"));
  @override
  List<Activity> get allAcivities => _activities;
}

void main() {
  setUp(() {});
  testWidgets('Detail Segment Test', (WidgetTester tester) async {

        MockActivityController mockActivityController = MockActivityController();
    // lo pasamos al DI de Get
    Get.put<ActivityController>(mockActivityController);
    // agregamos la línea siguiente para registrar el controlador
    // aquí instanciamos el mock controller
    MockSegmentController mockSegmentController = MockSegmentController();
    // lo pasamos al DI de Get
    Get.put<SegmentController>(mockSegmentController);


    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: SegmentDetailView(
        segmento: Segment(
            id: "1",
            idUser: "2",
            name: "NOMBRE",
            start: "INICIO",
            end: "FIN",
            startCoordinate: const LatLng(0, 0),
            endCoordinate: const LatLng(0, 0)),
      ),
    )));
    await tester.pump();

    //Se verifica que se esten mostrando los elementos que deben ir en esta vista
    expect(find.widgetWithText(AppBar, "NOMBRE"), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsOneWidget);
    expect(find.text('Mejor tiempo'), findsOneWidget);
    expect(find.text('Tiempo promedio'), findsOneWidget);
    expect(find.text("00:00:00"), findsNWidgets(2));
    expect(find.byIcon(Icons.control_point), findsNWidgets(2));
    expect(find.text('Ranking:'), findsOneWidget);
    expect(find.byType(DataTable), findsOneWidget);

    Get.delete<SegmentController>();
  });
}
