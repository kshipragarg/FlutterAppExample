import 'package:firstApp/models/product.dart';
import 'package:firstApp/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _name;
  double _price;
  String _productID;
  var uuid = Uuid();

  String get name => _name;
  double get price => _price;
  String get produtID => _productID;

  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  loadValues(Product product) {
    _name = product.name;
    _price = product.price;
    _productID = product.productID;
  }

  saveProduct() {
    var newProduct = Product(name: name, price: price, productID: uuid.v4());
    firestoreService.saveProduct(newProduct);
  }

  removeProduct(String productId) {
    firestoreService.removeProduct(productId);
  }
}
