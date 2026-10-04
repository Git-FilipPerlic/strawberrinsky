// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Strawberrinsky';

  @override
  String get modeChoiceTitle => 'Who uses this phone?';

  @override
  String get modeSimpleTitle => 'Simple mode';

  @override
  String get modeSimpleDescription =>
      'For an older person: large text and one big button.';

  @override
  String get modeFullTitle => 'Full mode';

  @override
  String get modeFullDescription =>
      'For family members: rooms, scanning and history.';

  @override
  String get simpleHomeQuestion => 'What are you looking for?';

  @override
  String get holdToExitSimpleMode => 'Hold for 3 seconds to leave simple mode';

  @override
  String get fullHomeEmpty => 'Rooms, scanning and history will be here.';

  @override
  String get switchToSimpleMode => 'Switch to simple mode';
}
