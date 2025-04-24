import 'package:plovo/models/dish.dart';

class CartDish {
  final Dish dish;
  final int amount;

  const CartDish({required this.dish, required this.amount});

  double get total {
    return dish.price * amount;
  }

  CartDish copyWith({Dish? dish, int? amount}) {
    return CartDish(dish: dish ?? this.dish, amount: amount ?? this.amount);
  }
}

class Cart {
  final List<CartDish> cartDishes;

  const Cart({required this.cartDishes});

  Cart addDish(Dish dish) {
    final existingDishIndex = cartDishes.indexWhere(
      (cartDish) => cartDish.dish.id == dish.id,
    );

    if (existingDishIndex != -1) {
      final updatedDishes = List<CartDish>.from(cartDishes);
      final existingCartDish = updatedDishes[existingDishIndex];
      final existingCartDishCopy = existingCartDish.copyWith(
        amount: existingCartDish.amount + 1,
      );
      updatedDishes[existingDishIndex] = existingCartDishCopy;

      return Cart(cartDishes: updatedDishes);
    }

    return Cart(cartDishes: [...cartDishes, CartDish(dish: dish, amount: 1)]);
  }

  Cart removeDish(Dish dish) {
    final existingDishIndex = cartDishes.indexWhere(
      (cartDish) => cartDish.dish.id == dish.id,
    );

    if (existingDishIndex == -1) {
      return this;
    }

    final existingCartDish = cartDishes[existingDishIndex];

    if (existingCartDish.amount > 1) {
      final updatedCartDishes = List<CartDish>.from(cartDishes);
      final existingCartDishCopy = existingCartDish.copyWith(
        amount: existingCartDish.amount - 1,
      );
      updatedCartDishes[existingDishIndex] = existingCartDishCopy;

      return Cart(cartDishes: updatedCartDishes);
    }

    final updatedCartDishes = List<CartDish>.from(cartDishes)
      ..removeAt(existingDishIndex);

    return Cart(cartDishes: updatedCartDishes);
  }

  double get total {
    return cartDishes.fold(0, (total, cartDish) => total + cartDish.total);
  }

  int get totalItems {
    return cartDishes.fold(0, (total, cartDish) => total + cartDish.amount);
  }
}
