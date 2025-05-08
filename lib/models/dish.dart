class Dish {
  final String id;
  final String restaurantId;
  final String name;
  final String image;
  final double price;

  Dish({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.image,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'image': image,
      'price': price,
    };
  }
}
