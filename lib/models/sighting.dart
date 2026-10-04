import 'detected_item.dart';

/// Jedno viđenje stvari: šta, u kojoj sobi, gde tačno, kada, i mala slika.
class Sighting {
  const Sighting({
    required this.id,
    required this.item,
    required this.roomId,
    required this.seenAt,
    this.imagePath,
  });

  final String id;
  final DetectedItem item;
  final String roomId;
  final DateTime seenAt;

  /// Putanja do male slike na telefonu. `null` ako slike nema.
  final String? imagePath;

  Map<String, Object?> toMap() => {
    'id': id,
    'nameSr': item.nameSr,
    'nameEn': item.nameEn,
    'placeSr': item.placeSr,
    'placeEn': item.placeEn,
    'roomId': roomId,
    'seenAt': seenAt.millisecondsSinceEpoch,
    'imagePath': imagePath,
  };

  /// Vraća `null` ako podatak nije upotrebljiv (nema id-a, sobe,
  /// vremena ili bar jednog naziva). Ostalo što nedostaje postaje prazno.
  static Sighting? fromMap(Map<String, Object?> map) {
    String text(String key) {
      final value = map[key];
      return value is String ? value : '';
    }

    final id = text('id');
    final roomId = text('roomId');
    final seenAt = map['seenAt'];
    var nameSr = text('nameSr');
    var nameEn = text('nameEn');

    if (id.isEmpty || roomId.isEmpty || seenAt is! int) return null;
    if (nameSr.isEmpty && nameEn.isEmpty) return null;
    // Ako fali naziv na jednom jeziku, bolje i drugi nego ništa.
    if (nameSr.isEmpty) nameSr = nameEn;
    if (nameEn.isEmpty) nameEn = nameSr;

    final imagePath = map['imagePath'];

    return Sighting(
      id: id,
      item: DetectedItem(
        nameSr: nameSr,
        nameEn: nameEn,
        placeSr: text('placeSr'),
        placeEn: text('placeEn'),
      ),
      roomId: roomId,
      seenAt: DateTime.fromMillisecondsSinceEpoch(seenAt),
      imagePath: imagePath is String && imagePath.isNotEmpty ? imagePath : null,
    );
  }
}
