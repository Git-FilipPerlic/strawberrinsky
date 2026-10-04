import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:strawberrinsky/app.dart';
import 'package:strawberrinsky/models/app_mode.dart';
import 'package:strawberrinsky/services/settings_store.dart';
import 'package:strawberrinsky/theme/app_theme.dart';

Future<void> _startApp(
  WidgetTester tester, {
  Locale locale = const Locale('sr'),
  Map<String, Object> saved = const {},
}) async {
  SharedPreferences.setMockInitialValues(saved);
  tester.platformDispatcher.localesTestValue = [locale];
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);

  await tester.pumpWidget(StrawberrinskyApp());
  await tester.pumpAndSettle();
}

void main() {
  group('Jezik', () {
    testWidgets('srpski telefon — srpski (latinica)', (tester) async {
      await _startApp(tester);
      expect(find.text('Ko koristi ovaj telefon?'), findsOneWidget);
    });

    testWidgets('engleski telefon — engleski', (tester) async {
      await _startApp(tester, locale: const Locale('en', 'US'));
      expect(find.text('Who uses this phone?'), findsOneWidget);
    });

    testWidgets('neki drugi jezik — pada na engleski', (tester) async {
      await _startApp(tester, locale: const Locale('de'));
      expect(find.text('Who uses this phone?'), findsOneWidget);
    });
  });

  group('Režim', () {
    testWidgets('izbor jednostavnog režima se pamti', (tester) async {
      await _startApp(tester);

      await tester.tap(find.text('Jednostavan režim'));
      await tester.pumpAndSettle();

      expect(find.text('Šta tražiš?'), findsOneWidget);
      expect(await SettingsStore().loadMode(), AppMode.simple);
    });

    testWidgets('sačuvan režim se otvara odmah', (tester) async {
      await _startApp(tester, saved: {'app_mode': 'full'});
      expect(find.text('Pređi na jednostavan režim'), findsOneWidget);
    });

    testWidgets('nečitljiv sačuvan režim — pita ponovo', (tester) async {
      await _startApp(tester, saved: {'app_mode': 'nesto'});
      expect(find.text('Ko koristi ovaj telefon?'), findsOneWidget);
    });

    testWidgets('kratak dodir u uglu NE izlazi iz jednostavnog režima', (
      tester,
    ) async {
      await _startApp(tester, saved: {'app_mode': 'simple'});

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      expect(find.text('Šta tražiš?'), findsOneWidget);
    });

    testWidgets('držanje 3 sekunde izlazi u pun režim', (tester) async {
      await _startApp(tester, saved: {'app_mode': 'simple'});

      final gesture = await tester.startGesture(
        tester.getCenter(find.byIcon(Icons.settings)),
      );
      await tester.pump(); // prvi kadar — tu krene odbrojavanje
      await tester.pump(const Duration(seconds: 3));
      await tester.pump(const Duration(milliseconds: 100));
      await gesture.up();
      await tester.pumpAndSettle();

      expect(find.text('Pređi na jednostavan režim'), findsOneWidget);
      expect(await SettingsStore().loadMode(), AppMode.full);
    });
  });

  test('Jednostavan režim ima krupniji tekst', () {
    final full = AppTheme.full().textTheme.bodyLarge!.fontSize!;
    final simple = AppTheme.simple().textTheme.bodyLarge!.fontSize!;
    expect(simple, greaterThan(full));
  });
}
