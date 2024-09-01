class Restaurant {
  final int id;
  final String name;
  final String cuisine;
  final String image;

  Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.image,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        id: json['id'],
        name: json['name'],
        cuisine: json['cuisine'],
        image: json['image']);
  }
}
