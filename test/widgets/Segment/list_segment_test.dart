import 'package:exercise_tracker/ui/Segment/controllers/segment_controller.dart';
import 'package:exercise_tracker/ui/Segment/models/segment_model.dart';
import 'package:exercise_tracker/ui/Segment/pages/segment_history.dart';
import 'package:exercise_tracker/ui/User/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';

class MockSegmentController extends GetxService
    with Mock
    implements SegmentController {
  final List<Segment> _segments = [
    Segment(
        id: "1",
        idUser: "3",
        name: "LA 59",
        start: "CRA 72 #88-61",
        end: "CRA 41 #59-36",
        startCoordinate: const LatLng(0, 0),
        endCoordinate: const LatLng(0, 0))
  ].obs;

  @override
  List<Segment> get allSegments => _segments;
  @override
  List<Segment> get mySegments =>
      List<Segment>.from(_segments.where((element) => element.idUser == "2"));

  @override
  void addSegment(String name, String start, String end, LatLng startCoordinate,
      LatLng endCoordinate) {
    Segment segmentToAdd = Segment(
        id: (_segments.length + 1).toString(),
        idUser: "2",
        name: name,
        start: start,
        end: end,
        startCoordinate: startCoordinate,
        endCoordinate: endCoordinate);
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

    //Se verifica que se esten mostrando los elementos que deben ir en esta vista
    expect(find.widgetWithText(AppBar, "SEGMENTOS"), findsOneWidget);
    expect(find.byIcon(Icons.directions_run), findsOneWidget);
    expect(find.byIcon(Icons.watch_later), findsOneWidget);
    expect(find.byIcon(Icons.segment), findsOneWidget);
    expect(find.byIcon(Icons.public_off), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);

    //Se añade un nuevo segmento manualmente y posteriormente se valida que si se este mostrando en la lista de la vista
    mockSegmentController.addSegment("NUEVO", "INICIO", "FIN", const LatLng(0,0), const LatLng(0,0));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNWidgets(2));

    //Se cambia la lista para que solo se muestren solo los segmentos creados por el ususario con id =1, es decir, el segmento creado anteriormente y se verifica que si se este mostrando la cantidad real
    await tester.tap(find.byIcon(Icons.public_off));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsOneWidget);

    //Se toma ese segmento creado por el usuario con id = 1, se desliza a la izquierda para borrarlo y se verifica que se haya borrado
    final cardFinder = find.byType(Card);
    await tester.drag(cardFinder, const Offset(-500.0, 0.0));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNothing);

    //Se vuelve a la vista de todos los segmentos y verificamos que la cantidad que se muestra es la correcta despues de eliminar un segmentot
    await tester.tap(find.byIcon(Icons.public));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsOneWidget);

    Get.delete<SegmentController>();
    Get.delete<UserController>();
  });
}
