import 'package:flutter/material.dart';
import '../models/order_model.dart';
import 'package:intl/intl.dart';
import '../models/product_model.dart';
import '../providers/orders_provider.dart';

class OrderItem extends StatefulWidget {
  final Order order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    List<Product> cartProducts = widget.order.cartItems;
    List<Product> cartProductsSorted = cartProducts.toSet().toList();
    return !isExpanded
        ? Card(
            elevation: 10,
            child: ListTile(
              leading: Column(
                children: <Widget>[
                  Text('\$ ${widget.order.totalCost}'),
                  Text(
                    DateFormat.yMd().format(widget.order.time),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: !isExpanded ? Icon(Icons.expand_more) : Icon(Icons.expand_less),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ),
          )
        : Card(
            elevation: 10,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Column(
                    children: <Widget>[
                      Text('\$ ${widget.order.totalCost}'),
                      Text(
                        DateFormat.yMd().format(widget.order.time),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: !isExpanded ? Icon(Icons.expand_more) : Icon(Icons.expand_less),
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: cartProductsSorted.map((product) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            product.title.toString(),
                          ),
                          Text('${product.currentItemCount}x \$${product.price}')
                        ],
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          );
  }
}
