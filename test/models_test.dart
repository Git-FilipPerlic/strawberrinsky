import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:strawberrinsky/models/detected_item.dart';
import 'package:strawberrinsky/models/room.dart';
import 'package:strawberrinsky/models/sighting.dart';
import 'package:strawberrinsky/services/mock_vision_service.dart';

void main() {
  group('Room', () {
    test('čuvanje i čitanje daju istu sobu', () {
      const room = Room(id: 'r1', name: 'Dnevna soba');
      expect(Room.fromMap(room.toMap()), room);
    });

    test('bez id-a — nije upotrebljivo', () {
      expect(Room.fromMap({'name': 'Kuhinja'}), isNull);
    });

    test('bez naziva — prazan naziv, ne pada', () {
      expect(Room.fromMap({'id': 'r1'})?.name, '');
    });
  });

  group('Sighting', () {
    final sighting = Sighting(
      id: 's1',
      item: const DetectedItem(
        nameSr: 'naočare',
        nameEn: 'glasses',
        placeSr: 'na stočiću',
        placeEn: 'on the table',
      ),
      roomId: 'r1',
      seenAt: DateTime(2026, 10, 4, 12, 30),
      imagePath: 'slike/s1.jpg',
    );

    test('čuvanje i čitanje daju isto viđenje', () {
      final copy = Sighting.fromMap(sighting.toMap())!;
      expect(copy.id, 's1');
      expect(copy.item, sighting.item);
      expect(copy.roomId, 'r1');
      expect(copy.seenAt, sighting.seenAt);
      expect(copy.imagePath, 'slike/s1.jpg');
    });

    test('bez slike i opisa mesta — ne pada', () {
      final copy = Sighting.fromMap({
        'id': 's2',
        'nameSr': 'ključevi',
        'roomId': 'r1',
        'seenAt': 0,
      })!;
      expect(copy.imagePath, isNull);
      expect(copy.item.placeSr, '');
      // Engleski naziv fali — uzima se srpski.
      expect(copy.item.nameEn, 'ključevi');
    });

    test('bez naziva, sobe ili vremena — nije upotrebljivo', () {
      final base = sighting.toMap();
      expect(Sighting.fromMap({...base, 'nameSr': '', 'nameEn': ''}), isNull);
      expect(Sighting.fromMap({...base, 'roomId': null}), isNull);
      expect(Sighting.fromMap({...base, 'seenAt': 'juče'}), isNull);
    });
  });

  group('MockVisionService', () {
    test('vraća spremljene odgovore ukrug, uključujući prazan', () async {
      final vision = MockVisionService(delay: Duration.zero);
      final image = Uint8List(0);

      final answers = [for (var i = 0; i < 5; i++) await vision.detect(image)];

      expect(answers[0].first.nameSr, 'naočare za čitanje');
      expect(answers[3], isEmpty);
      expect(answers[4], answers[0]); // krenuo ispočetka
    });
  });
}
