import 'package:flutter/cupertino.dart';
import 'package:login/models/product.dart';
import 'package:login/widgets/api_product_list_row.dart';

class ProductListWidget extends StatefulWidget {
  late List<Product> products = <Product>[];

  ProductListWidget(List<Product> products) {
    this.products = products;
  }

  @override
  State<StatefulWidget> createState() {
    return ProductListWidgetState();
  }
}

class ProductListWidgetState extends State<ProductListWidget> {
  @override
  Widget build(BuildContext context) {
    return buildProductList(context);
  }

  Widget buildProductList(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10.0,),
        SizedBox(
            height: 500,
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(widget.products.length, (index) {
                return ProductListRowWidget(widget.products[index]);
              }),
            ))
      ],
    );
  }
}
