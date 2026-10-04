// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get appTitle => 'Strawberrinsky';

  @override
  String get modeChoiceTitle => 'Ko koristi ovaj telefon?';

  @override
  String get modeSimpleTitle => 'Jednostavan režim';

  @override
  String get modeSimpleDescription =>
      'Za stariju osobu: krupan tekst i jedno veliko dugme.';

  @override
  String get modeFullTitle => 'Pun režim';

  @override
  String get modeFullDescription => 'Za ukućane: sobe, snimanje i istorija.';

  @override
  String get simpleHomeQuestion => 'Šta tražiš?';

  @override
  String get holdToExitSimpleMode =>
      'Drži 3 sekunde za izlaz iz jednostavnog režima';

  @override
  String get fullHomeEmpty => 'Ovde će biti sobe, snimanje i istorija.';

  @override
  String get switchToSimpleMode => 'Pređi na jednostavan režim';
}
