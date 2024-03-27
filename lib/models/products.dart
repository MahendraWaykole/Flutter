class Product {
  final int productId;
  final String productName;
  final double productCost;
  final String productDesc;
  final bool isActive;

  const Product(
      {this.productId = 0,
      required this.productName,
      required this.productCost,
      required this.productDesc,
      required this.isActive});
  factory Product.fromJson(Map<String, dynamic> json) => Product(
      productId: json['productId'],
      productName: json['productName'],
      productCost: json['productCost'].toDouble(),
      productDesc: json['productDesc'],
      isActive: json['isActive']);

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productCost": productCost,
        "productDesc": productDesc,
        "isActive": isActive,
      };
}
