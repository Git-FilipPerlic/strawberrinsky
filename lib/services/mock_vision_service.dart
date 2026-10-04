import 'dart:typed_data';

import '../models/detected_item.dart';
import 'vision_service.dart';

/// Lažni AI za razvoj — ne gleda sliku i ništa ne košta.
/// Svaki poziv vraća sledeći unapred spremljen odgovor, ukrug.
class MockVisionService implements VisionService {
  MockVisionService({this.delay = const Duration(milliseconds: 600)});

  /// Koliko „razmišlja", da bi se u aplikaciji video znak čekanja.
  final Duration delay;

  int _next = 0;

  static const List<List<DetectedItem>> _answers = [
    [
      DetectedItem(
        nameSr: 'naočare za čitanje',
        nameEn: 'reading glasses',
        placeSr: 'na stočiću, pored daljinskog',
        placeEn: 'on the coffee table, next to the remote',
      ),
      DetectedItem(
        nameSr: 'daljinski upravljač',
        nameEn: 'remote control',
        placeSr: 'na stočiću',
        placeEn: 'on the coffee table',
      ),
    ],
    [
      DetectedItem(
        nameSr: 'ključevi',
        nameEn: 'keys',
        placeSr: 'na polici kod vrata',
        placeEn: 'on the shelf by the door',
      ),
      DetectedItem(
        nameSr: 'novčanik',
        nameEn: 'wallet',
        placeSr: 'u činiji na komodi',
        placeEn: 'in the bowl on the dresser',
      ),
    ],
    [
      DetectedItem(
        nameSr: 'mobilni telefon',
        nameEn: 'mobile phone',
        placeSr: 'na fotelji, ispod jastuka',
        placeEn: 'on the armchair, under the cushion',
      ),
    ],
    // Ponekad se na slici ne vidi ništa korisno.
    [],
  ];

  @override
  Future<List<DetectedItem>> detect(Uint8List imageBytes) async {
    await Future<void>.delayed(delay);
    final answer = _answers[_next];
    _next = (_next + 1) % _answers.length;
    return answer;
  }
}
