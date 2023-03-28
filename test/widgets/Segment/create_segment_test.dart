import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:exercise_tracker/ui/Segment/models/segment_model.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_create.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class MockSegmentController extends GetxService
    with Mock
    implements SegmentController {
  final List<Segment> _segments = [
    Segment(
        id: "1",
        idUser: "2",
        name: "LA 59",
        start: "CRA 72 #88-61",
        end: "CRA 41 #59-36")
  ].obs;

  @override
  List<Segment> get allSegments => _segments;
  @override
  List<Segment> get mySegments =>
      List<Segment>.from(_segments.where((element) => element.idUser == "1"));

  @override
  void addSegment(String name, String start, String end) {
    print("Hola");
    Segment segmentToAdd = Segment(
        id: (_segments.length + 1).toString(),
        idUser: "1",
        name: name,
        start: start,
        end: end);
    _segments.add(segmentToAdd);
  }
}

void main() {
  setUp(() {});
  testWidgets('Create Segment Test', (WidgetTester tester) async {
    // agregamos la línea siguiente para registrar el controlador
    // aquí instanciamos el mock controller

    MockSegmentController mockSegmentController = MockSegmentController();
    // lo pasamos al DI de Get
    Get.put<SegmentController>(mockSegmentController);
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: SegmentCreationView(),
    )));
    await tester.pump();

    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsNWidgets(2));

    // Presionar el botón de crear segmento sin llenar ningún campo
    await tester.tap(find.widgetWithText(ElevatedButton, 'CREAR SEGMENTO'));
    await tester.pumpAndSettle();
    expect(find.text('Error'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.enterText(find.byType(TextField).at(0), 'Segmento 1');
    await tester.enterText(find.byType(TextField).at(1), 'Inicio');
    await tester.enterText(find.byType(TextField).at(2), 'Fin');
    await tester.tap(find.widgetWithText(ElevatedButton, 'CREAR SEGMENTO'));
    await tester.pumpAndSettle();

    expect(mockSegmentController.allSegments.length, 2);
    expect(mockSegmentController.allSegments[1].name, 'Segmento 1');
    expect(mockSegmentController.allSegments[1].start, 'Inicio');
    expect(mockSegmentController.allSegments[1].end, 'Fin');

    Get.delete<SegmentController>();
  });
}
