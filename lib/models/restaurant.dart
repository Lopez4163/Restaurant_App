class Restaurant {
  final int id;
  final String name;
  final String cuisine;
  final String image;
  final String slogan;
  final String phone;
  final String address;

  Restaurant(
      {required this.id,
      required this.name,
      required this.cuisine,
      required this.image,
      required this.slogan,
      required this.phone,
      required this.address});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        id: json['id'],
        name: json['name'],
        cuisine: json['cuisine'],
        image: json['image'],
        slogan: json['slogan'],
        phone: json['phone'],
        address: json['address']);
  }
}
