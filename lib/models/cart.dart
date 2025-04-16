import 'package:plovo/models/dish.dart';

class CartDish {
  Dish dish;
  int amount;

  CartDish({required this.dish, required this.amount});

  double get total {
    return dish.price * amount;
  }
}

class Cart {
  List<CartDish> cartDishes = [];

  void addDish(Dish dish) {
    try {
      final cartDish = cartDishes.firstWhere(
        (cartDish) => cartDish.dish.id == dish.id,
      );

      cartDish.amount++;
    } catch (error) {
      cartDishes.add(CartDish(dish: dish, amount: 1));
    }
  }

  void removeDish(Dish dish) {
    final cartDish = cartDishes.firstWhere(
      (cartDish) => cartDish.dish.id == dish.id,
    );

    if (cartDish.amount > 1) {
      cartDish.amount--;
    } else {
      cartDishes.remove(cartDish);
    }
  }

  double get total {
    return cartDishes.fold(0, (total, cartDish) => total + cartDish.total);
  }

  int get totalItems {
    return cartDishes.fold(0, (total, cartDish) => total + cartDish.amount);
  }
}
