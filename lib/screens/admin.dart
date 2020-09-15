import 'package:ecommerceadmin/db/brand.dart';
import 'package:ecommerceadmin/db/category.dart';
import 'package:ecommerceadmin/screens/add_product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor noActive = Colors.grey;
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: <Widget>[
            Expanded(
              child: FlatButton.icon(
                onPressed: () {
                  setState(() => _selectedPage = Page.dashboard);
                },
                label: Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 16),
                ),
                icon: Icon(Icons.dashboard),
                color: _selectedPage == Page.dashboard ? active : noActive,
              ),
            ),
            Expanded(
              child: FlatButton.icon(
                onPressed: () {
                  setState(() => _selectedPage = Page.manage);
                },
                icon: Icon(Icons.sort),
                label: Text(
                  'Manage',
                  style: TextStyle(fontSize: 16),
                ),
                color: _selectedPage == Page.manage ? active : noActive,
              ),
            )
          ],
        ),
      ),
      body: loading(),
    );
  }

  Widget loading() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(
                "Revenue",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              subtitle: FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.attach_money,
                    color: Colors.green,
                    size: 30,
                  ),
                  label: Text(
                    "1200",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 28,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Card(
                      child: ListTile(
                        subtitle: Text(
                          "7",
                          style: TextStyle(fontSize: 60, color: active),
                          textAlign: TextAlign.center,
                        ),
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.person_outline),
                            label: Text(
                              "Users",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Card(
                      child: ListTile(
                        subtitle: Text(
                          "7",
                          style: TextStyle(fontSize: 60, color: active),
                          textAlign: TextAlign.center,
                        ),
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.category),
                            label: Text(
                              "Category",
                              style: TextStyle(fontSize: 17),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Card(
                      child: ListTile(
                        subtitle: Text(
                          "7",
                          style: TextStyle(fontSize: 60, color: active),
                          textAlign: TextAlign.center,
                        ),
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.track_changes),
                            label: Text(
                              "Produce",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Card(
                      child: ListTile(
                        subtitle: Text(
                          "7",
                          style: TextStyle(fontSize: 60, color: active),
                          textAlign: TextAlign.center,
                        ),
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.tag_faces),
                            label: Text(
                              "Sold",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Card(
                      child: ListTile(
                        subtitle: Text(
                          "7",
                          style: TextStyle(fontSize: 60, color: active),
                          textAlign: TextAlign.center,
                        ),
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.shopping_cart),
                            label: Text(
                              "Orders",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Card(
                      child: ListTile(
                        subtitle: Text(
                          "7",
                          style: TextStyle(fontSize: 60, color: active),
                          textAlign: TextAlign.center,
                        ),
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.close),
                            label: Text(
                              "Return",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProduct()));
              },
              title: Text("Add Product"),
              leading: Icon(Icons.add),
            ),
            Divider(),
            ListTile(
              onTap: () {},
              title: Text("Product list"),
              leading: Icon(Icons.change_history),
            ),
            Divider(),
            ListTile(
              onTap: () {
                _categoryAlert();
              },
              title: Text("Add Category"),
              leading: Icon(Icons.add_circle),
            ),
            Divider(),
            ListTile(
              onTap: () {},
              title: Text("Category list"),
              leading: Icon(Icons.category),
            ),
            Divider(),
            ListTile(
              onTap: () {
                _brandAlert();
              },
              title: Text("Add Brand"),
              leading: Icon(Icons.add_circle_outline),
            ),
            Divider(),
            ListTile(
              onTap: () {
                BrandService().getBrands();
              },
              title: Text("Brand list"),
              leading: Icon(Icons.library_books),
            )
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _categoryAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: _categoryController,
          decoration: InputDecoration(hintText: 'add category'),
          validator: (value) {
            if (value.isEmpty) {
              return "category can't be empty";
            }
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('ADD'),
          onPressed: () {
            if (_categoryController.text != null) {
              _categoryService.createCategory(_categoryController.text);
            }
//            FlutterToast.showToast(child: Text('category added'));
            Navigator.pop(context);
          },
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        )
      ],
    );
    showDialog(context: context, builder: (context) => alert);
  }

  void _brandAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: _brandController,
          decoration: InputDecoration(hintText: 'add brand'),
          validator: (value) {
            if (value.isEmpty) {
              return "category can't be empty";
            }
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('ADD'),
          onPressed: () {
            if (_brandController.text != null) {
              _brandService.createBrand(_brandController.text);
            }
            // FlutterToast.showToast(child: Text('category added'));
            Navigator.pop(context);
          },
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        )
      ],
    );
    showDialog(context: context, builder: (context) => alert);
  }
}
