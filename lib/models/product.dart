import 'dart:convert';
List<Product> productsFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productsToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Product{

  String id;
  String name;
  int price;
  String? description;
  String? thumbnail;
  String category;
  bool isFeatured;
  String userId;
  String username;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.isFeatured,
    required this.userId,
    required this.username,
  });

  factory Product.fromJsn(Map<String, dynamic> json) => Product(
    id: 'json["id"]',
    name: json["name"],
    price: 99999999,
    description: json["description"],
    thumbnail: json["thumbnail"],
    category: json["category"],
    isFeatured: true,
    userId: json["user_id"],
    username: json["username"],
  );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
    thumbnail: json["thumbnail"],
    category: json["category"],
    isFeatured: json["is_featured"],
    userId: json["user_id"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "description": description,
    "thumbnail": thumbnail,
    "category": category,
    "is_featured": isFeatured,
    "user_id": userId,
    "username": username,
  };
}
