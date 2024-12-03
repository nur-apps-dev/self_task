class Product {
  final String title;
  final String imageUrl;
  final double price;

  Product({required this.title, required this.imageUrl, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      imageUrl: json['image'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
