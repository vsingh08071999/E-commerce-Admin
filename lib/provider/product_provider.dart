import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  List<String> selectedColor = [];
  addColors(String color) {
    selectedColor.add(color);
    print(selectedColor.length.toString());
    notifyListeners();
  }

  removeColors(String color) {
    selectedColor.remove(color);
    print(selectedColor.length.toString());
    notifyListeners();
  }
}
