import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:strawberrinsky/app.dart';
import 'package:strawberrinsky/theme/app_theme.dart';

void main() {
  testWidgets('Srpski telefon — tekst na srpskom (latinica)', (tester) async {
    tester.platformDispatcher.localesTestValue = const [Locale('sr')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(const StrawberrinskyApp());
    await tester.pumpAndSettle();

    expect(find.text('Pomoći ću ti da pronađeš svoje stvari.'), findsOneWidget);
    expect(find.text('Srpski'), findsOneWidget);
  });

  testWidgets('Engleski telefon — tekst na engleskom', (tester) async {
    tester.platformDispatcher.localesTestValue = const [Locale('en', 'US')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(const StrawberrinskyApp());
    await tester.pumpAndSettle();

    expect(find.text('I will help you find your things.'), findsOneWidget);
  });

  testWidgets('Neki drugi jezik — pada na engleski', (tester) async {
    tester.platformDispatcher.localesTestValue = const [Locale('de')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(const StrawberrinskyApp());
    await tester.pumpAndSettle();

    expect(find.text('English'), findsOneWidget);
  });

  test('Jednostavan režim ima krupniji tekst', () {
    final full = AppTheme.full().textTheme.bodyLarge!.fontSize!;
    final simple = AppTheme.simple().textTheme.bodyLarge!.fontSize!;
    expect(simple, greaterThan(full));
  });
}
