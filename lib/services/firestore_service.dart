
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstApp/models/product.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveProduct(Product product) {
    return _db
        .collection('products')
        .doc(product.productID)
        .set(product.toMap());
  }
// need to intitalize firebase before use wo kaha hai

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Product.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeProduct(String productId) {
    return _db.collection('products').doc(productId).delete();
  }
}
