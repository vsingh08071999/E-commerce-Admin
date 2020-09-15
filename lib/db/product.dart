import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  Firestore _firestore = Firestore.instance;
  String ref = "products";
  void uploadProducts(Map<String, dynamic> data) {
    var id = Uuid();
    String productId = id.v1(); // generate the indivitual ID for products
    data["id"] = productId;
    _firestore.collection(ref).document(productId).setData(data);
  }
}
