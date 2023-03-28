import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:exercise_tracker/ui/Segment/models/segment_model.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_detail.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_history.dart';
import 'package:exercise_tracker/ui/User/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class MockSegmentController extends GetxService
    with Mock
    implements SegmentController {}

void main() {
  setUp(() {});
  testWidgets('Detail Segment Test', (WidgetTester tester) async {
    Get.put(UserController());
    // agregamos la línea siguiente para registrar el controlador
    // aquí instanciamos el mock controller
    MockSegmentController mockSegmentController = MockSegmentController();
    // lo pasamos al DI de Get
    Get.put<SegmentController>(mockSegmentController);
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: SegmentDetailView(
        segmento: Segment(
            id: "1", idUser: "1", name: "NOMBRE", start: "INICIO", end: "FIN"),
      ),
    )));
    await tester.pump();

    expect(find.widgetWithText(AppBar, "NOMBRE"), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsOneWidget);
    expect(find.text('Mejor tiempo'), findsOneWidget);
    expect(find.text('Tiempo promedio'), findsOneWidget);
    expect(find.text("00.00.00"), findsNWidgets(2));
    expect(find.byIcon(Icons.control_point), findsNWidgets(2));
    expect(find.text('Ranking:'), findsOneWidget);
    expect(find.byType(DataTable), findsOneWidget);

    Get.delete<SegmentController>();
  });
}
