import 'package:plovo/models/cart.dart';
import 'package:plovo/models/restaurant.dart';
import 'package:plovo/models/user.dart';

class CreateOrderRequest {
  final Restaurant restaurant;
  final List<CartDish> cartDishes;
  final User user;
  final DateTime createdAt;

  CreateOrderRequest({
    required this.restaurant,
    required this.cartDishes,
    required this.user,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'restaurant': restaurant.toJson(),
      'cartDishes': cartDishes.map((cartDish) => cartDish.toJson()).toList(),
      'user': user.toJson(),
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }
}
