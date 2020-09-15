import 'dart:io';
import 'package:ecommerceadmin/db/brand.dart';
import 'package:ecommerceadmin/db/category.dart';
import 'package:ecommerceadmin/db/product.dart';
import 'package:ecommerceadmin/provider/product_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService _productService = ProductService();
  GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> brandsDropdown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> categoriesDropdown =
      <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  List<String> selectedSizes = <String>[];
  File _image1;
  bool isLoading = false;
  List<String> colors = <String>[];
  bool onSale = false;
  bool featured = false;
  Color whiteColor = Colors.white;
  Color blackColor = Colors.black;
  Color redColor = Colors.red;
  Color yelloColor = Colors.yellow;
  Color greenColor = Colors.green;
  Color blueColor = Colors.blue;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _getSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      elevation: 2,
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {
    _getCategories();
    _getBrands();
  }

  List<DropdownMenuItem<String>> getCategoryDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      items.insert(
          0,
          DropdownMenuItem(
            child: Text(categories[i].data['category']),
            value: categories[i].data['category'],
          ));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      items.insert(
          0,
          DropdownMenuItem(
            child: Text(brands[i].data['brand']),
            value: brands[i].data['brand'],
          ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.2,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'add product',
          style: TextStyle(
              color: black, fontSize: 22, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _globalKey,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.36,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: OutlineButton(
                            onPressed: () {
                              _selectImage(ImagePicker.pickImage(
                                  source: ImageSource.gallery));
                            },
                            color: grey,
                            child: _displayChild1(),
                            borderSide: BorderSide(
                                color: grey.withOpacity(0.5), width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Available Colors",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            if (productProvider.selectedColor
                                .contains('whiteColor')) {
                              productProvider.removeColors('whiteColor');
                            } else {
                              productProvider.addColors('whiteColor');
                            }
                            setState(() {
                              colors = productProvider.selectedColor;
                            });
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                color: productProvider.selectedColor
                                        .contains('whiteColor')
                                    ? red
                                    : grey,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            if (productProvider.selectedColor
                                .contains('blackColor')) {
                              productProvider.removeColors('blackColor');
                            } else {
                              productProvider.addColors('blackColor');
                            }
                            setState(() {
                              colors = productProvider.selectedColor;
                            });
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                color: productProvider.selectedColor
                                        .contains('blackColor')
                                    ? red
                                    : grey,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            if (productProvider.selectedColor
                                .contains('redColor')) {
                              productProvider.removeColors('redColor');
                            } else {
                              productProvider.addColors('redColor');
                            }
                            setState(() {
                              colors = productProvider.selectedColor;
                            });
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                color: productProvider.selectedColor
                                        .contains('redColor')
                                    ? red
                                    : grey,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            if (productProvider.selectedColor
                                .contains('yellowColor')) {
                              productProvider.removeColors('yellowColor');
                            } else {
                              productProvider.addColors('yellowColor');
                            }
                            setState(() {
                              colors = productProvider.selectedColor;
                            });
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                color: productProvider.selectedColor
                                        .contains('yellowColor')
                                    ? red
                                    : grey,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: CircleAvatar(
                                backgroundColor: Colors.yellow,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            if (productProvider.selectedColor
                                .contains('greenColor')) {
                              productProvider.removeColors('greenColor');
                            } else {
                              productProvider.addColors('greenColor');
                            }
                            setState(() {
                              colors = productProvider.selectedColor;
                            });
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                color: productProvider.selectedColor
                                        .contains('greenColor')
                                    ? red
                                    : grey,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            if (productProvider.selectedColor
                                .contains('blueColor')) {
                              productProvider.removeColors('blueColor');
                            } else {
                              productProvider.addColors('blueColor');
                            }
                            setState(() {
                              colors = productProvider.selectedColor;
                            });
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                color: productProvider.selectedColor
                                        .contains('blueColor')
                                    ? red
                                    : grey,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    "Available Sizes",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: selectedSizes.contains('XS'),
                        onChanged: (value) => {changeSelectedSize('XS')},
                      ),
                      Text("XS"),
                      Checkbox(
                        value: selectedSizes.contains('S'),
                        onChanged: (value) => {changeSelectedSize('S')},
                      ),
                      Text("S"),
                      Checkbox(
                        value: selectedSizes.contains('M'),
                        onChanged: (value) => {changeSelectedSize('M')},
                      ),
                      Text("M"),
                      Checkbox(
                        value: selectedSizes.contains('L'),
                        onChanged: (value) => {changeSelectedSize('L')},
                      ),
                      Text("L"),
                      Checkbox(
                        value: selectedSizes.contains('XL'),
                        onChanged: (value) => {changeSelectedSize('XL')},
                      ),
                      Text("XL"),
                      Checkbox(
                        value: selectedSizes.contains('XXL'),
                        onChanged: (value) => {changeSelectedSize('XXL')},
                      ),
                      Text("XXL"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Sale',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Switch(
                            value: onSale,
                            onChanged: (changeValue) {
                              setState(() {
                                onSale = changeValue;
                              });
                            },
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Featured',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Switch(
                            value: featured,
                            onChanged: (changeValue) {
                              setState(() {
                                featured = changeValue;
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "enter a product name with 10 characters at maximum",
                      style: TextStyle(color: red, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    child: TextFormField(
                      controller: _productNameController,
                      decoration: InputDecoration(hintText: 'Product Name'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "You must enter the product name";
                        } else if (value.length > 10) {
                          return "Product name can't have more than 10 characters";
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Category :",
                          style: TextStyle(color: red),
                        ),
                      ),
                      DropdownButton(
                        items: categoriesDropdown,
                        value: _currentCategory,
                        onChanged: changeSelectedCategory,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Brand :",
                          style: TextStyle(color: red),
                        ),
                      ),
                      DropdownButton(
                        items: brandsDropdown,
                        value: _currentBrand,
                        onChanged: changeSelectedBrand,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(hintText: 'Quantity'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "You must enter the quantity";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        hintText: 'Price',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "You must enter a price";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 140),
                    child: RaisedButton(
                      onPressed: () {
                        _validateAndUploadProduct();
                      },
                      child: Text(
                        "add product",
                        style: TextStyle(fontSize: 18),
                      ),
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    setState(() {
      categories = data;
      categoriesDropdown = getCategoryDropdown();
      _currentCategory = categories[0].data['category'];
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    setState(() {
      brands = data;
      brandsDropdown = getBrandDropdown();
      _currentBrand = brands[0].data['brand'];
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentBrand = selectedBrand);
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
        print(selectedSizes);
      });
    } else
      setState(() {
        selectedSizes.insert(0, size);
        print(selectedSizes);
      });
  }

  void _selectImage(Future<File> pickImage) async {
    File tempImage = await pickImage;
    setState(() {
      _image1 = tempImage;
    });
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 14),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        width: double.infinity,
        fit: BoxFit.fill,
      );
    }
  }

  _validateAndUploadProduct() async {
    if (_globalKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (_image1 != null) {
        if (selectedSizes.isNotEmpty) {
          String imageURL1;
          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg"; // generate different url for every Image
          print(picture1);
          StorageUploadTask task1 = storage
              .ref()
              .child(picture1)
              .putFile(_image1); // it upload the task on firebase storage
          StorageTaskSnapshot snapshot1;
          snapshot1 = await task1.onComplete.then((snapshot) => snapshot);
          task1.onComplete.then((snapshot3) async {
            imageURL1 = await snapshot1.ref.getDownloadURL();
            _productService.uploadProducts({
              "name": _productNameController.text,
              "price": double.parse(_priceController.text),
              "sizes": selectedSizes,
              "colors": colors,
              "picture": imageURL1,
              "quantity": int.parse(_quantityController.text),
              "brand": _currentBrand,
              "category": _currentCategory,
              "sale": onSale,
              "featured": featured
            });
            _globalKey.currentState.reset();
            setState(() => isLoading = false);
            //Fluttertoast.showToast(msg: "add product");
            _getSnackBar("Add Product");
            print("added");
            Navigator.pop(context);
          });
        } else {
          setState(() => isLoading = false);
          _getSnackBar("select atleast one size");
          print("select atleast one size");
          //Fluttertoast.showToast(msg: "select atleast one size");
        }
      } else {
        setState(() => isLoading = false);
        _getSnackBar("must upload all the Images");
        print("must upload all the Images");
        // Fluttertoast.showToast(msg: "must upload all the Images");
      }
    }
  }
}
