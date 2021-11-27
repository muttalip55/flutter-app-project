import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/api/category_api.dart';
import 'package:login/api/product_api.dart';
import 'package:login/models/category.dart';
import 'package:login/models/product.dart';
import 'package:login/widgets/appbar_widget.dart';
import 'package:login/widgets/product_list_widget.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ApiScreenState();
  }
}

class ApiScreenState extends State {
  List<Category> categories = <Category>[];
  List<Widget> categoryWidgets = <Widget>[];
  List<Product> products = <Product>[];
  @override
  void initState() {
    getCategoriesFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBarWidget("RESTFUL"),
      body:SingleChildScrollView(
     child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0,),
            SingleChildScrollView(
              padding: EdgeInsets.all(15.0),
              scrollDirection: Axis.horizontal,
              child: Row(children: categoryWidgets),
            ),
            ProductListWidget(products),
            SizedBox(height: 10.0,),
          ],
        ),
      ),
      ),
    );
  }

  void getCategoriesFromApi() {
    CategoryApi.getCategories().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.categories =
            list.map((category) => Category.fromJson(category)).toList();
        getCategoryWidgets();
      });
    });
  }

  List<Widget> getCategoryWidgets() {
    for (int i = 0; i < categories.length; i++) {
      categoryWidgets.add(getCategoryWidget(categories[i]));
    }
    return categoryWidgets;
  }

  Widget getCategoryWidget(Category category) {
    return FlatButton(
      color: Colors.lime.shade50,
      child: Text(
        category.categoryName,
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
      ),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.lightBlue),),
      onPressed: () {
        getProductByCategoryId(category);
      },
    );
  }

  void getProductByCategoryId(Category category) {
    ProductApi.getProductByCategoryId(category.id).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.products =
            list.map((product) => Product.fromJson(product)).toList();
        getCategoryWidgets();
      });
    });
  }
}
