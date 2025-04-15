import 'package:flutter/material.dart';
import 'package:plovo/models/cart.dart';

class CartDishTile extends StatelessWidget {
  final CartDish cartDish;
  final void Function() onAdded;
  final void Function() onRemoved;

  const CartDishTile({
    super.key,
    required this.cartDish,
    required this.onAdded,
    required this.onRemoved,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: AssetImage(cartDish.dish.image)),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartDish.dish.name,
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${cartDish.total.toStringAsFixed(2)} KGS',
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemoved,
            iconSize: 18,
            icon: Icon(cartDish.amount == 1 ? Icons.delete : Icons.remove),
          ),
          SizedBox(
            width: 20,
            child: Text(
              cartDish.amount.toString(),
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(onPressed: onAdded, iconSize: 18, icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}
