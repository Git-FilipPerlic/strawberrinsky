import 'package:flutter/material.dart';

/// Razmaci koji se koriste kroz celu aplikaciju.
class AppSpacing {
  AppSpacing._();

  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;
  static const double extraLarge = 40;
}

/// Boje i izgled aplikacije.
///
/// Postoje dve varijante:
/// - [AppTheme.full] — običan tekst, za ukućane (pun režim);
/// - [AppTheme.simple] — krupan tekst i velika dugmad, za stariju osobu
///   (jednostavan režim).
class AppTheme {
  AppTheme._();

  /// Glavna boja — tamna jagoda. Dovoljno tamna da beli tekst na njoj
  /// bude lako čitljiv.
  static const Color strawberry = Color(0xFFB3261E);

  /// Koliko je tekst veći u jednostavnom režimu.
  static const double simpleTextFactor = 1.4;

  static ThemeData full() => _build(textFactor: 1.0, buttonHeight: 48);

  static ThemeData simple() =>
      _build(textFactor: simpleTextFactor, buttonHeight: 72);

  static ThemeData _build({
    required double textFactor,
    required double buttonHeight,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: strawberry,
      primary: strawberry,
      // Jak kontrast teksta na pozadini — lakše za čitanje.
      onSurface: Colors.black,
    );

    final base = ThemeData(colorScheme: colorScheme, useMaterial3: true);
    final buttonSize = Size(buttonHeight, buttonHeight);
    const buttonPadding = EdgeInsets.symmetric(
      horizontal: AppSpacing.large,
      vertical: AppSpacing.medium,
    );

    // Veličine slova stoje u `englishLike` (važi i za latinicu), pa se
    // tek posle spajanja mogu uvećati.
    final sizedText = Typography.englishLike2021.merge(base.textTheme);

    return base.copyWith(
      textTheme: sizedText.apply(fontSizeFactor: textFactor),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: buttonSize,
          padding: buttonPadding,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: buttonSize,
          padding: buttonPadding,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: buttonSize,
          padding: buttonPadding,
        ),
      ),
    );
  }
}
