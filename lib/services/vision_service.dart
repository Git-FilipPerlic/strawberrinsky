import 'dart:typed_data';

import '../models/detected_item.dart';

/// Slika → spisak stvari i gde stoje.
///
/// Ekrani znaju samo za ovaj interfejs, ne i da li iza njega stoji
/// lažni AI ([MockVisionService]) ili pravi AI u oblaku (CLOUD-001).
abstract class VisionService {
  /// Vraća prepoznate stvari (može biti prazan spisak).
  /// Baca [VisionException] ako prepoznavanje ne uspe (npr. nema mreže).
  Future<List<DetectedItem>> detect(Uint8List imageBytes);
}

class VisionException implements Exception {
  const VisionException(this.message);

  final String message;

  @override
  String toString() => 'VisionException: $message';
}
