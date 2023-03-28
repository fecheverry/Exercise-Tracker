import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:exercise_tracker/ui/Segment/models/segment_model.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_history.dart';
import 'package:exercise_tracker/ui/User/controllers/user_controller.dart';
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
    Segment segmentToAdd = Segment(
        id: (_segments.length + 1).toString(),
        idUser: "1",
        name: name,
        start: start,
        end: end);
    _segments.add(segmentToAdd);
  }

  @override
  void removeSegment(elem) {
    _segments.remove(elem);
  }
}

void main() {
  setUp(() {});
  testWidgets('List Segments Test', (WidgetTester tester) async {
    Get.put(UserController());
    // agregamos la línea siguiente para registrar el controlador
    // aquí instanciamos el mock controller
    MockSegmentController mockSegmentController = MockSegmentController();
    // lo pasamos al DI de Get
    Get.put<SegmentController>(mockSegmentController);
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
      body: SegmentHistoryView(),
    )));
    await tester.pump();

    expect(find.widgetWithText(AppBar, "SEGMENTOS"), findsOneWidget);
    expect(find.byIcon(Icons.directions_run), findsOneWidget);
    expect(find.byIcon(Icons.watch_later), findsOneWidget);
    expect(find.byIcon(Icons.segment), findsOneWidget);

    expect(find.byIcon(Icons.public_off), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    expect(find.byType(Card), findsOneWidget);
    mockSegmentController.addSegment("NUEVO", "INICIO", "FIN");
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.public_off));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsOneWidget);

    final cardFinder = find.byType(Card);

    // arrastra la tarjeta hacia la izquierda
    await tester.drag(cardFinder, const Offset(-500.0, 0.0));
    await tester.pumpAndSettle();

    // verifica que la tarjeta se ha eliminado
    expect(find.byType(Card), findsNothing);

    await tester.tap(find.byIcon(Icons.public));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsOneWidget);

    Get.delete<SegmentController>();
    Get.delete<UserController>();
  });
}
