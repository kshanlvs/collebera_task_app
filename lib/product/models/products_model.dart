class Products {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final int quantity;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.quantity = 1,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
     
      quantity: json['quantity'] ?? 1,
    );
  }

  Products copyWith({
    int? id,
    String? title,
    num? price,
    String? description,
    String? category,
    String? image,

    int? quantity,
  }) {
    return Products(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,

      quantity: quantity ?? this.quantity,
    );
  }
}
