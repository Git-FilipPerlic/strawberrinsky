import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'models/app_mode.dart';
import 'screens/full/full_home_screen.dart';
import 'screens/mode_choice_screen.dart';
import 'screens/simple/simple_home_screen.dart';
import 'services/settings_store.dart';
import 'theme/app_theme.dart';

/// Srpski, latinica. Naši prevodi su u `app_sr.arb`, a ugrađeni tekstovi
/// Flutter-a (npr. „U redu", „Otkaži") se tako takođe prikazuju latinicom.
const Locale serbianLatin = Locale.fromSubtags(
  languageCode: 'sr',
  scriptCode: 'Latn',
);

const Locale english = Locale('en');

class StrawberrinskyApp extends StatefulWidget {
  StrawberrinskyApp({super.key, SettingsStore? settings})
    : settings = settings ?? SettingsStore();

  final SettingsStore settings;

  @override
  State<StrawberrinskyApp> createState() => _StrawberrinskyAppState();
}

class _StrawberrinskyAppState extends State<StrawberrinskyApp> {
  /// Dok se čita sačuvani režim — kratko, ne prikazuje se ništa.
  bool _loading = true;

  /// `null` znači da režim još nije izabran.
  AppMode? _mode;

  @override
  void initState() {
    super.initState();
    _loadMode();
  }

  Future<void> _loadMode() async {
    final mode = await widget.settings.loadMode();
    if (!mounted) return;
    setState(() {
      _mode = mode;
      _loading = false;
    });
  }

  void _setMode(AppMode mode) {
    setState(() => _mode = mode);
    widget.settings.saveMode(mode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: _mode == AppMode.simple ? AppTheme.simple() : AppTheme.full(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [serbianLatin, english],
      localeResolutionCallback: _resolveLocale,
      home: _buildHome(),
    );
  }

  Widget _buildHome() {
    if (_loading) return const Scaffold();

    return switch (_mode) {
      null => ModeChoiceScreen(onModeChosen: _setMode),
      AppMode.simple => SimpleHomeScreen(
        onExit: () => _setMode(AppMode.full),
      ),
      AppMode.full => FullHomeScreen(
        onSwitchToSimple: () => _setMode(AppMode.simple),
      ),
    };
  }

  /// Ako je telefon na srpskom — srpski, inače engleski.
  static Locale _resolveLocale(Locale? deviceLocale, Iterable<Locale> _) {
    if (deviceLocale?.languageCode == 'sr') return serbianLatin;
    return english;
  }
}
