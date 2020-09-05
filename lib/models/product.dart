class Product {
  final String productID;
  final String name;
  final double price;

  Product({this.productID, this.price, this.name});

  Map<String, dynamic> toMap() {
    return {'productId': productID, 'name': name, 'price': price};
  }

  Product.fromFirestore(Map<String, dynamic> firestore)
      : productID = firestore['productId'],
        name = firestore['name'],
        price = firestore['price'];
}
