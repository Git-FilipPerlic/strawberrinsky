import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/hold_to_activate_button.dart';

/// Jednostavan režim (starija osoba).
/// Za sada samo naslov — veliko dugme „Šta tražiš?" dolazi u SIMPLE-001.
class SimpleHomeScreen extends StatelessWidget {
  const SimpleHomeScreen({super.key, required this.onExit});

  /// Povratak u pun režim (dugme se drži 3 sekunde).
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.large),
                child: Text(
                  l10n.simpleHomeQuestion,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: AppSpacing.small,
              right: AppSpacing.small,
              child: HoldToActivateButton(
                icon: Icons.settings,
                label: l10n.holdToExitSimpleMode,
                onActivated: onExit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
