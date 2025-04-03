import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;

  const ActionButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final theme = Theme.of(context);

    return Positioned(
      bottom: bottomPadding,
      left: 0,
      right: 0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: theme.colorScheme.onPrimaryContainer,
          foregroundColor: theme.colorScheme.primaryContainer,
        ),
        child: child,
      ),
    );
  }
}
