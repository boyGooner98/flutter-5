import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    Product product = routeArgs['item'];
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Text(product.description),
            Text('\$ ${product.price.toString()}'),
          ],
        ));
  }
}
