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

## BASE-002 — izbor režima (4. oktobar 2026)

- Dodat paket (odobren): `shared_preferences` — pamti izabrani režim.
- Prvo pokretanje: ekran „Ko koristi ovaj telefon?" sa dva izbora.
  Izbor se pamti; sledeći put aplikacija odmah otvara taj režim.
- Jednostavan režim: krupna tema, za sada samo „Šta tražiš?" (dugme
  dolazi u SIMPLE-001). Izlaz: malo dugme u uglu koje se **drži 3 sekunde**
  (krug se popunjava), kratak dodir ne radi ništa.
- Pun režim: za sada prazan ekran + dugme „Pređi na jednostavan režim".
- Ako je sačuvana vrednost nečitljiva ili čuvanje ne uspe — aplikacija
  ponovo pita, ne pada.
- `flutter analyze` — bez grešaka; 9 testova prolazi.
- Sledeće: BASE-003, modeli i mock servisi.

## BASE-003 — modeli i lažni AI (4. oktobar 2026)

- Bez novih paketa.
- Modeli (`lib/models/`):
  - `Room` — soba (id, naziv).
  - `DetectedItem` — šta je AI video: naziv i opis mesta, na srpskom i
    engleskom (da odgovor može da se izgovori na jeziku telefona).
  - `Sighting` — jedno viđenje: stvar, soba, vreme, slika (može da fali).
  - Svi znaju da se pretvore u podatak za čuvanje i nazad; oštećen ili
    nepotpun podatak daje `null` / prazno, nikad pad.
- `VisionService` — interfejs „slika → spisak stvari".
  `MockVisionService` — lažni AI: ne gleda sliku, vraća 4 spremljena
  odgovora ukrug (jedan je prazan, da se vidi i to stanje).
- Još se nigde ne prikazuje na ekranu — koristi se od SCAN-002.
- `flutter analyze` — bez grešaka; 16 testova prolazi.
- Sledeće: ROOM-001, spisak soba.
