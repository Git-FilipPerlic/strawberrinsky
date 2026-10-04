# Beleške o radu

## 4. oktobar 2026

- Napravljen folder i repo, prazan Flutter starter (Android, iOS).
  `flutter analyze` — bez grešaka.
- Odluke: prvo kamera telefona (fiksne kamere kasnije), AI u oblaku,
  dva režima (starija osoba / ukućani), srpski i engleski.
- Nacrt arhitekture i spiska feature-a upisan u `CLAUDE.md`.
- Sledeće: korisnik potvrđuje spisak, pa BASE-001.

## BASE-001 — tema, krupan tekst, dva jezika (4. oktobar 2026)

- Dodati paketi (odobreni): `flutter_localizations`, `intl`.
- Prevodi: `lib/l10n/app_sr.arb` (srpski, latinica — glavni) i `app_en.arb`.
  Posle izmene `.arb` fajla: `flutter gen-l10n` (ili samo `flutter run`).
- Jezik se bira po telefonu: srpski telefon → srpski, sve ostalo → engleski.
  Ugrađeni tekstovi Flutter-a idu latinicom (`sr_Latn`), ne ćirilicom.
- Tema: `lib/theme/app_theme.dart` — boja jagode, `AppTheme.full()` (običan
  tekst) i `AppTheme.simple()` (tekst 1,4× veći, dugmad 72 px).
- Početni ekran je privremen — samo pokazuje pozdrav na izabranom jeziku.
- `flutter analyze` — bez grešaka; 4 testa prolaze.
- Sledeće: BASE-002, izbor režima.
