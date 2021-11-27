import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/models/product.dart';

class ProductListRowWidget extends StatelessWidget{

  Product product;
  ProductListRowWidget(this.product);

  @override
  Widget build(BuildContext context) {

    return buildProductItemCard(context,product);
  }

}

Widget buildProductItemCard(BuildContext context, Product product) {
  return InkWell(
    child: Card(
      child: Column(
        children: [
          Container(
            child: Image.network("https://cdn.pixabay.com/photo/2021/09/17/12/12/coffee-6632524_960_720.jpg"),
            height: 100.0,
            width: MediaQuery.of(context).size.width/2,
          ),
          Text(product.productName),
          Text(product.unitPrice.toString() + " TL", style: TextStyle(fontSize: 18.0, color: Colors.amber),)
        ],
      ),
    ),
  );

}