import 'package:plovo/models/cart.dart';

class CartScreenArguments {
  final String restaurantId;
  final Cart cart;

  CartScreenArguments({required this.restaurantId, required this.cart});
}
