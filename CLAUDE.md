# strawberrinsky — Flutter

Kamera + AI za pomoć starijima i osobama sa demencijom. Ukućani premeštaju
stvari i ne sete se gde su ih ostavili. Izgovoriš naziv stvari, a aplikacija
kaže (i pokaže slikom) gde je poslednji put viđena.

Jedan kod za Android i iOS. Šifra projekta u razgovorima: **strawberrynski**.

- folder: `D:\All Work\strawberrinsky`
- repo: https://github.com/Git-FilipPerlic/strawberrinsky
- Dart paket: `strawberrinsky`, org `com.strawberrinsky`
- Flutter SDK: `C:\src\flutter\bin`

## Status (4. oktobar 2026)

Prazan Flutter starter. Arhitektura i spisak feature-a su **nacrt** — čekaju
potvrdu korisnika pre prvog koda.

---

## Pravila rada za AI asistenta

1. **Mali koraci.** Jedan feature = jedna izmena = jedna provera.
2. **Posle svake izmene `flutter analyze`**, i prijaviti rezultat.
3. **Ne dodavati pakete bez pitanja.** Svaki paket je odluka korisnika.
4. **Ne izmišljati feature-e.** Radi se ono što je u spisku niže ili što
   korisnik izričito traži. Ako nešto nije jasno — pitati.
5. **Ne dirati arhitekturu usput.** Predlog promene se iznese, pa se čeka.
6. **Widgeti su „glupi"** — primaju podatke kroz konstruktor. Samo ekrani
   pričaju sa servisima.
7. **Svaki podatak može da nedostaje** — prazno stanje, nikad pad.
8. **Posle feature-a kratka beleška u `APP_NOTES.md`.**
9. **Objašnjavati jednostavno** — korisnik nije profesionalni programer.
10. Ne mešati sa projektom `event_app` — to je druga aplikacija.

---

## Odluke korisnika (4. oktobar 2026)

| Pitanje | Odluka |
|---|---|
| Odakle slika | **Prvo kamera telefona**, fiksne kamere u kući kasnije — arhitektura mora da ostavi mesta za njih |
| Gde radi AI | **U oblaku** (npr. Claude) — prepoznaje gotovo sve i razume opise („plave naočare za čitanje") |
| Ko koristi | **Oba**: jednostavan režim za stariju osobu + pun režim za ukućane |
| Jezik | **Srpski i engleski** od početka |

## Šta iz toga sledi (bitno pre prvog koda)

- **API ključ za AI ne sme da stoji u aplikaciji.** Iz APK-a se lako izvuče i
  neko drugi troši na tvoj račun. Zato aplikacija ne priča direktno sa AI
  servisom, nego preko **malog posrednika na serveru** (predlog: Firebase
  Cloud Functions, jer je Firebase već poznat iz e-vent projekta). Ključ
  stoji samo na serveru.
- **Slike napuštaju kuću.** To je cena izbora „AI u oblaku". Ukućani to moraju
  da znaju — pri prvom pokretanju jasno piše šta se šalje i gde. Slike se ne
  čuvaju na serveru duže nego što traje prepoznavanje.
- **Svako slanje slike košta.** Zato se ne šalje svaki kadar, nego jedna slika
  na nekoliko sekundi, i samo dok traje snimanje sobe.
- **Bez interneta** traženje i dalje radi nad onim što je već zapamćeno;
  samo novo snimanje čeka mrežu.
- **Izvor slike je zamenljiv.** Ekrani ne znaju da li slika dolazi iz telefona
  ili iz fiksne kamere — to je posao `ImageSource` sloja. Tako se fiksne
  kamere kasnije dodaju bez prepravljanja ekrana.

## Kako radi (osnovni tok)

1. **Snimanje sobe** — ukućanin izabere sobu („Dnevna soba") i polako prođe
   telefonom kroz nju. Aplikacija na svakih par sekundi pošalje sliku AI-u,
   koji vrati spisak stvari i gde stoje („naočare — na stočiću, pored
   daljinskog").
2. **Pamćenje** — za svaku stvar se pamti: naziv (srpski i engleski), soba,
   opis mesta, mala slika, vreme kad je viđena. Pamti se **na telefonu**.
3. **Traženje** — veliko dugme, izgovoriš „naočare", aplikacija kaže glasom i
   pokaže: „Dnevna soba, na stočiću pored daljinskog — viđeno pre 2 sata", uz
   sliku.

## Arhitektura (predlog)

```
lib/
  main.dart
  app.dart                  - MaterialApp, tema, izbor režima
  theme/app_theme.dart      - boje, razmaci, krupan tekst za jednostavan režim
  l10n/                     - prevodi: srpski (latinica) i engleski
  models/
    room.dart               - Room (id, naziv)
    sighting.dart           - Sighting: stvar, soba, opis mesta, slika, vreme
  services/
    image_source.dart       - interfejs: odakle dolazi slika
    phone_camera_source.dart- kamera telefona (prva verzija)
    vision_service.dart     - interfejs: slika -> spisak stvari i mesta
    cloud_vision_service.dart - preko posrednika na serveru
    mock_vision_service.dart  - lažni odgovori za razvoj bez troška
    memory_store.dart       - čuvanje viđenih stvari na telefonu
    search_service.dart     - pronalaženje stvari po izgovorenom nazivu
    voice_service.dart      - govor u tekst i tekst u govor
  screens/
    simple/                 - jednostavan režim (starija osoba)
    full/                   - pun režim (ukućani: sobe, snimanje, istorija)
  widgets/
    common/
functions/                  - posrednik na serveru (kasnije)
```

Ključno: **mock servis za AI postoji od prvog dana**, pa se ekrani prave i
testiraju bez ijednog plaćenog poziva.

State management: `setState` + servisi (isto kao u e-vent), dok se ne pokaže
potreba za više.

## Spisak feature-a (nacrt — čeka potvrdu)

Radi se odozgo nadole.

| ID | Šta | Status |
|---|---|---|
| BASE-001 | Tema, krupan tekst, dva jezika (sr / en) | — |
| BASE-002 | Skelet: izbor režima (jednostavan / pun) | — |
| BASE-003 | Modeli i mock servisi (soba, viđena stvar, lažni AI) | — |
| ROOM-001 | Spisak soba: dodaj, preimenuj, obriši | — |
| SCAN-001 | Kamera telefona: pregled i slikanje na par sekundi | — |
| SCAN-002 | Slanje slike AI-u (prvo mock) i prikaz šta je prepoznato | — |
| SCAN-003 | Pamćenje viđenih stvari po sobi, sa slikom i vremenom | — |
| FIND-001 | Traženje kucanjem: naziv → soba, mesto, slika, „pre koliko" | — |
| FIND-002 | Traženje glasom (srpski i engleski) | — |
| FIND-003 | Odgovor glasom („Naočare su u dnevnoj sobi, na stočiću") | — |
| SIMPLE-001 | Jednostavan režim: jedno ogromno dugme „Šta tražiš?" | — |
| CLOUD-001 | Posrednik na serveru, pravi AI umesto mock-a | — |
| CLOUD-002 | Obaveštenje o privatnosti pri prvom pokretanju | — |
| HIST-001 | Istorija: gde je stvar sve viđena | — |
| CAM-001 | Fiksne kamere u kući (kasnije) | — |

## Paketi (predlog — ništa nije instalirano bez odobrenja)

| Namena | Paket |
|---|---|
| Kamera | `camera` |
| Govor u tekst | `speech_to_text` |
| Tekst u govor | `flutter_tts` |
| Čuvanje na telefonu | `sqflite` (ili `shared_preferences` za sitnice) |
| Prevodi | `flutter_localizations` + `intl` |
| Poziv posredniku | `http` (ili `cloud_functions`) |
| Dozvole | `permission_handler` |

## Kako pokrenuti

```powershell
cd "D:\All Work\strawberrinsky"
flutter pub get
flutter run
```

Rad na tri računara: pre rada `git pull`, posle rada `git add .`,
`git commit -m "..."`, `git push`.
