import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/indicator/pacman_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart';
import '../models/order_model.dart';
import '../widgets/order_item.dart';
import 'package:loading/loading.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _init = true;
  bool loading = true;
  @override
  void didChangeDependencies() async {
    if (_init) {
      await Provider.of<Orders>(context).getOrders();
      setState(() {
        loading = false;
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Order> orderItems = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: Loading(
                indicator:PacmanIndicator() ,
                color: Colors.pink,
                size: 100,
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView.builder(
                itemBuilder: (context, index) => OrderItem(orderItems[index]),
                itemCount: orderItems.length,
              ),
            ),
    );
  }
}
