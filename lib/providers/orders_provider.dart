import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Orders extends ChangeNotifier {
  List<Order> orders = [];
  String token;
  String userId;
  Orders(this.token, this.orders,this.userId);
  Future<void> getOrders() async {
    var response = await http.get('https://ecom-flutter-108dc.firebaseio.com/$userId/orders.json?auth=$token');
    final orderItems = json.decode(response.body) as Map<String, Object>;
    List<Order> temp = [];
    if (orderItems != null && orderItems.keys.length > 0) {
      orderItems.forEach((key, value) {
        Map<String, Object> innerMap = orderItems[key];
        List<dynamic> tempList = innerMap['cartItems'];
        List<Product> tempProductList = [];
        for (int i = 0; i < tempList.length; i++) {
          Map<String, Object> listMap = tempList[i];
          Product product = new Product(
              id: listMap['id'],
              price: listMap['price'],
              title: listMap['title'],
              currentItemCount: listMap['currentItemCount']);
          tempProductList.add(product);
        }
        Order tempOrder = new Order(
            tempProductList, double.parse(innerMap['totalCost'].toString()), DateTime.parse(innerMap['time']));
        temp.add(tempOrder);
      });
    }
    orders = temp;
    notifyListeners();
  }

  Future<void> addOrder(List<Product> cartProducts, double amount, DateTime currentTime) async {
    if (amount == 0.0) return;
    Fluttertoast.showToast(msg: 'order placed Sucessfully !!!', toastLength: Toast.LENGTH_SHORT);
    List<Product> products = [];
    for (int i = 0; i < cartProducts.length; i++) {
      cartProducts[i].currentItemCount = cartProducts[i].itemCount;
      products.add(cartProducts[i]);
    }
    List<Map<String, Object>> map = [];
    for (int i = 0; i < products.length; i++) {
      Map<String, Object> temp = {
        'id': products[i].id,
        'title': products[i].title,
        'price': products[i].price,
        'currentItemCount': products[i].currentItemCount
      };
      map.add(temp);
    }
    var response = await http.post('https://ecom-flutter-108dc.firebaseio.com/$userId/orders.json?auth=$token',
        body: json.encode({'cartItems': map, 'totalCost': amount, 'time': currentTime.toString()}));
    Order order = new Order(products, amount, currentTime);
    orders = [...orders, order];
    notifyListeners();
  }
}
