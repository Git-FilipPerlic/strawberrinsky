import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_mode.dart';

/// Sitna podešavanja sačuvana na telefonu (za sada samo izabrani režim).
class SettingsStore {
  static const _modeKey = 'app_mode';

  /// Vraća sačuvani režim, ili `null` ako još nije izabran
  /// (ili ako je sačuvana vrednost nečitljiva).
  Future<AppMode?> loadMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString(_modeKey);
      for (final mode in AppMode.values) {
        if (mode.name == name) return mode;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Čuva režim. Ako čuvanje ne uspe, aplikacija i dalje radi —
  /// samo će sledeći put ponovo pitati.
  Future<void> saveMode(AppMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_modeKey, mode.name);
    } catch (_) {
      // Namerno ćutimo — vidi opis iznad.
    }
  }
}
