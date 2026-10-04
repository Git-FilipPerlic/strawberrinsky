import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';

/// Pun režim (ukućani). Za sada prazan — sobe, snimanje i istorija
/// dolaze u sledećim feature-ima.
class FullHomeScreen extends StatelessWidget {
  const FullHomeScreen({super.key, required this.onSwitchToSimple});

  final VoidCallback onSwitchToSimple;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.fullHomeEmpty,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.extraLarge),
              OutlinedButton.icon(
                onPressed: onSwitchToSimple,
                icon: const Icon(Icons.elderly),
                label: Text(l10n.switchToSimpleMode),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
