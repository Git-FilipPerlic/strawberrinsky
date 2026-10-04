/// Jedna stvar koju je AI prepoznao na slici, i gde stoji.
/// Naziv i opis mesta dolaze na oba jezika, da bi odgovor mogao da se
/// izgovori na jeziku telefona.
class DetectedItem {
  const DetectedItem({
    required this.nameSr,
    required this.nameEn,
    this.placeSr = '',
    this.placeEn = '',
  });

  /// npr. „naočare"
  final String nameSr;

  /// npr. "glasses"
  final String nameEn;

  /// npr. „na stočiću, pored daljinskog" (može biti prazno)
  final String placeSr;

  /// npr. "on the coffee table, next to the remote" (može biti prazno)
  final String placeEn;

  @override
  bool operator ==(Object other) =>
      other is DetectedItem &&
      other.nameSr == nameSr &&
      other.nameEn == nameEn &&
      other.placeSr == placeSr &&
      other.placeEn == placeEn;

  @override
  int get hashCode => Object.hash(nameSr, nameEn, placeSr, placeEn);
}
