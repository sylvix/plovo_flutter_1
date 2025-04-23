import 'package:flutter/material.dart';
import 'package:plovo/widgets/center_placeholder.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  void goBackToMenu(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CenterPlaceholder(
      title: 'Your cart is empty',
      iconData: Icons.shopping_cart_outlined,
      buttonText: 'Go back to menu',
      onButtonPressed: () => goBackToMenu(context),
    );
  }
}
