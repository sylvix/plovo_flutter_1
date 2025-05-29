import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plovo/models/cart.dart';
import 'package:plovo/models/dish.dart';

class CartNotifier extends Notifier<Map<String, Cart>> {
  @override
  Map<String, Cart> build() {
    return {};
  }

  Cart _getCart(String restaurantId) {
    return state[restaurantId] ?? Cart(cartDishes: []);
  }

  void addDish(Dish dish) {
    state = {
      ...state,
      dish.restaurantId: _getCart(dish.restaurantId).addDish(dish),
    };
  }

  void removeDish(Dish dish) {
    state = {
      ...state,
      dish.restaurantId: _getCart(dish.restaurantId).removeDish(dish),
    };
  }
}

final cartProvider = NotifierProvider<CartNotifier, Map<String, Cart>>(() {
  return CartNotifier();
});

final cartByRestaurantIdProvider = Provider.family<Cart, String>((
  ref,
  restaurantId,
) {
  final carts = ref.watch(cartProvider);
  return carts[restaurantId] ?? Cart(cartDishes: []);
});
