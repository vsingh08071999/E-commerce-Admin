import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  Firestore _firestore = Firestore.instance;
  String ref = "brands";
  void createBrand(String name) {
    var id = Uuid();
    String categoryId = id.v1();
    _firestore.collection(ref).document(categoryId).setData({"brand": name});
  }

  Future<List> getBrands() {
    return _firestore.collection(ref).getDocuments().then((snaps) {
      print(snaps.documents.length);
      return snaps.documents;
    });
  }

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) {
    return _firestore
        .collection(ref)
        .where('brands', isEqualTo: suggestion)
        .getDocuments()
        .then((snaps) {
      return snaps.documents;
    });
  }
}
