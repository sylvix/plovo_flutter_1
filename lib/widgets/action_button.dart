import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final void Function() onPressed;
  final bool isLoading;
  final Widget child;

  const ActionButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final theme = Theme.of(context);

    return Positioned(
      bottom: bottomPadding,
      left: 0,
      right: 0,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: theme.colorScheme.onPrimaryContainer,
          foregroundColor: theme.colorScheme.primaryContainer,
        ),
        child:
            isLoading
                ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Loading'),
                    SizedBox(width: 8),
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: theme.disabledColor,
                        strokeWidth: 2,
                      ),
                    ),
                  ],
                )
                : child,
      ),
    );
  }
}
