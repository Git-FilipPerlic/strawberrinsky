import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/app_mode.dart';
import '../theme/app_theme.dart';

/// Prvo pokretanje: ko koristi ovaj telefon?
class ModeChoiceScreen extends StatelessWidget {
  const ModeChoiceScreen({super.key, required this.onModeChosen});

  final ValueChanged<AppMode> onModeChosen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.large),
          children: [
            Text(
              l10n.modeChoiceTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.extraLarge),
            _ModeOption(
              icon: Icons.elderly,
              title: l10n.modeSimpleTitle,
              description: l10n.modeSimpleDescription,
              onTap: () => onModeChosen(AppMode.simple),
            ),
            const SizedBox(height: AppSpacing.large),
            _ModeOption(
              icon: Icons.family_restroom,
              title: l10n.modeFullTitle,
              description: l10n.modeFullDescription,
              onTap: () => onModeChosen(AppMode.full),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeOption extends StatelessWidget {
  const _ModeOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.large),
          child: Row(
            children: [
              Icon(icon, size: 48),
              const SizedBox(width: AppSpacing.medium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.small),
                    Text(description, style: textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
