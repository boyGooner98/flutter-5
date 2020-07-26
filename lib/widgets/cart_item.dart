import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final Product product;
  CartItem(this.product);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(product);
      },
      background: Container(
        color: Colors.red,
        child: Container(
          margin: const EdgeInsets.only(right: 20),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 30,
          ),
        ),
        alignment: Alignment.centerRight,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple,
          radius: 30,
          child: Text(product.price.toString()),
        ),
        title: Text(
          product.title,
        ),
        subtitle: Text('\$ ${product.price * product.itemCount}'),
        trailing: Text('${product.itemCount}x'),
      ),
    );
  }
}
