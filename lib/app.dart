import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'theme/app_theme.dart';

/// Srpski, latinica. Naši prevodi su u `app_sr.arb`, a ugrađeni tekstovi
/// Flutter-a (npr. „U redu", „Otkaži") se tako takođe prikazuju latinicom.
const Locale serbianLatin = Locale.fromSubtags(
  languageCode: 'sr',
  scriptCode: 'Latn',
);

const Locale english = Locale('en');

class StrawberrinskyApp extends StatelessWidget {
  const StrawberrinskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      // Izbor režima (jednostavan / pun) dolazi u BASE-002.
      theme: AppTheme.full(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [serbianLatin, english],
      localeResolutionCallback: _resolveLocale,
      home: const _PlaceholderHome(),
    );
  }

  /// Ako je telefon na srpskom — srpski, inače engleski.
  static Locale _resolveLocale(Locale? deviceLocale, Iterable<Locale> _) {
    if (deviceLocale?.languageCode == 'sr') return serbianLatin;
    return english;
  }
}

/// Privremeni početni ekran — samo da se vide tema i prevod.
/// Zamenjuje ga izbor režima u BASE-002.
class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.homeGreeting,
                style: textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.medium),
              Text(l10n.languageName, style: textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
