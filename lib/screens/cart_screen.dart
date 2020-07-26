import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product_model.dart';
import '../widgets/cart_item.dart';
import '../providers/orders_provider.dart';
import 'package:loading/loading.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _init = true;
  bool loading = true;
  @override
  void didChangeDependencies() async {
    if (_init) {
      await Provider.of<Cart>(context).getCartItems();
      setState(() {
        loading = false;
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> cartProducts = Provider.of<Cart>(context).cartItems;
    double totalCost = Provider.of<Cart>(context).totalCartAmount();
    return Scaffold(
      appBar: AppBar(
        title: Text('your bag'),
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: Loading(
                indicator: BallBeatIndicator(),
                color: Colors.pink,
                size: 100,
              ),
            )
          : Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Text('Total'),
                          SizedBox(
                            width: 100,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.purple,
                            ),
                            width: 90,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '\$ ${totalCost.toString()}',
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          FlatButton(
                              child: Text('Order Now', style: TextStyle(color: Colors.purple)),
                              onPressed: () {
                                Provider.of<Orders>(context, listen: false)
                                    .addOrder(cartProducts, totalCost, DateTime.now());
                                Provider.of<Cart>(context, listen: false).emptyCart();
                              }),
                        ],
                      ),
                    ),
                  ),
                  cartProducts.length == 0
                      ? Center(child: Text('No Products have been added to the cart'))
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.70,
                          child: ListView.builder(
                            itemBuilder: (context, index) => CartItem(cartProducts[index]),
                            itemCount: cartProducts.length,
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
