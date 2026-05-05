class ProductModel {
  final int? id;
  final String? name;
  final num? price;
  final int? quantity;
  final String? manufacturedDate;
  final String? imageUrl;
  final bool? isDeleted;
  final int? categoryId;
  final String? createdAt;
  final String? updatedAt;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.manufacturedDate,
    this.imageUrl,
    this.isDeleted,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      manufacturedDate: json['manufacturedDate'],
      imageUrl: json['imageUrl'],
      isDeleted: json['isDeleted'],
      categoryId: json['categoryId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
