import 'package:flutter/material.dart';

/// Malo dugme koje radi tek kad se drži [holdDuration].
/// Dok se drži, krug oko ikonice se popunjava. Kratak dodir ne radi ništa.
class HoldToActivateButton extends StatefulWidget {
  const HoldToActivateButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onActivated,
    this.holdDuration = const Duration(seconds: 3),
  });

  final IconData icon;
  final String label;
  final VoidCallback onActivated;
  final Duration holdDuration;

  @override
  State<HoldToActivateButton> createState() => _HoldToActivateButtonState();
}

class _HoldToActivateButtonState extends State<HoldToActivateButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progress = AnimationController(
    vsync: this,
    duration: widget.holdDuration,
  )..addStatusListener(_onStatus);

  void _onStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _progress.reset();
      widget.onActivated();
    }
  }

  void _start() => _progress.forward(from: 0);

  void _cancel() {
    if (_progress.isAnimating) _progress.reset();
  }

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: widget.label,
      child: Listener(
        onPointerDown: (_) => _start(),
        onPointerUp: (_) => _cancel(),
        onPointerCancel: (_) => _cancel(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: AnimatedBuilder(
            animation: _progress,
            builder: (context, child) => Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: CircularProgressIndicator(
                    value: _progress.value,
                    strokeWidth: 4,
                    color: colors.primary,
                    backgroundColor: colors.surfaceContainerHighest,
                  ),
                ),
                child!,
              ],
            ),
            child: Icon(widget.icon, color: colors.onSurfaceVariant),
          ),
        ),
      ),
    );
  }
}
