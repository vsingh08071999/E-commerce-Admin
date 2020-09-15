import 'package:ecommerceadmin/provider/product_provider.dart';
import 'package:ecommerceadmin/screens/admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ProductProvider(),
      )
    ],
    child: MaterialApp(
      title: "Ecommerce Admin",
      home: Admin(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
