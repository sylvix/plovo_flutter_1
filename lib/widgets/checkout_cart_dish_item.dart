import 'package:flutter/material.dart';
import 'package:plovo/models/cart.dart';

class CheckoutCartDishItem extends StatelessWidget {
  final CartDish cartDish;

  const CheckoutCartDishItem({super.key, required this.cartDish});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text(
              'x${cartDish.amount}',
              style: theme.textTheme.titleSmall,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              cartDish.dish.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '${cartDish.total.toStringAsFixed(2)} KGS',
            style: theme.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
