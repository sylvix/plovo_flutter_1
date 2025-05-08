class Restaurant {
  final String id;
  final String name;
  final String image;

  Restaurant({required this.id, required this.name, required this.image});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image};
  }
}
