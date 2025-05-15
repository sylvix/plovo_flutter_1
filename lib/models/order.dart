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

class OrderListItem {
  final String id;
  final String restaurantName;
  final String restaurantImage;
  final double total;
  final DateTime createdAt;

  const OrderListItem({
    required this.id,
    required this.restaurantName,
    required this.restaurantImage,
    required this.total,
    required this.createdAt,
  });

  factory OrderListItem.fromJson(Map<String, dynamic> json) {
    final total = json['cartDishes'].fold(
      0,
      (sum, cartDish) => sum + cartDish['dish']['price'] * cartDish['amount'],
    );

    return OrderListItem(
      id: json['id'],
      restaurantName: json['restaurant']['name'],
      restaurantImage: json['restaurant']['image'],
      total: total,
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
    );
  }
}
