class Product {
  final int id;
  final String name;
  final String description;
  final String imageURL;
  final double price;
  final int categoryID;
  final String categoryName;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.price,
    required this.categoryID,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      imageURL: json['imageURL'] ?? '',
      price: json['price'].toDouble(),
      categoryID: json['categoryID'],
      categoryName: json['categoryName'],
    );
  }
}
