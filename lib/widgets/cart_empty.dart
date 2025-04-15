import 'package:flutter/material.dart';
import 'package:plovo/widgets/action_button.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  void goBackToMenu(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 100,
                color: theme.colorScheme.primary,
              ),
              SizedBox(height: 16),
              Text('Your cart is empty', style: theme.textTheme.titleMedium),
            ],
          ),
        ),
        ActionButton(
          onPressed: () => goBackToMenu(context),
          child: Text('Go back to menu'),
        ),
      ],
    );
  }
}
