import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cart with ChangeNotifier {
  List<Product> cartItems = [];
  double amount = 0.0;
  String token;
  String userId;
  Cart(this.token, this.cartItems,this.userId);
  Future<void> getCartItems() async {
    final url = 'https://ecom-flutter-108dc.firebaseio.com/$userId/cartItems.json?auth=$token';
    var response = await http.get(url);
    final cartProducts = json.decode(response.body) as Map<String, Object>;
    if (cartProducts != null && cartProducts.keys.length > 0) {
      List<Product> tempList = [];
      cartProducts.forEach((key, value) {
        Map<String, Object> innerMap = cartProducts[key];
        Product product = Product(
          id: key,
          title: innerMap['title'],
          description: innerMap['description'],
          price: innerMap['price'],
          itemCount: innerMap['itemcount'],
        );
        tempList.add(product);
      });
      cartItems = tempList;
      notifyListeners();
    }
  }

  Future<void> addItem(Product product) async {
    final url = 'https://ecom-flutter-108dc.firebaseio.com/$userId/cartItems.json?auth=$token';
    var response = await http.get(url);
    var productId = "";
    final productList = json.decode(response.body) as Map<String, Object>;
    if (productList != null && productList.keys.length > 0) {
      productList.forEach((key, value) {
        Map<String, Object> innerMap = productList[key];
        if (innerMap['id'] == product.id) {
          productId = key;
        }
      });
    }
    if (productId.length > 0) {
      await http.patch('https://ecom-flutter-108dc.firebaseio.com/$userId/cartItems/$productId.json?auth=$token',
          body: json.encode({
            'itemcount': product.itemCount + 1,
          }));
      cartItems.removeWhere((element) {
        if (element.id == product.id) {
          return true;
        }
        return false;
      });
      product.itemCount += 1;
      cartItems = [...cartItems, product];
    } else {
      product.itemCount = 1;
      cartItems = [...cartItems, product];
      var url1 = 'https://ecom-flutter-108dc.firebaseio.com/$userId/cartItems.json?auth=$token';
      await http.post(url1,
          body: json.encode({
            'id': product.id,
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'itemcount': product.itemCount,
          }));
    }
    notifyListeners();
  }

  Future<void> removeItem(Product item) async {
    await http.delete('https://ecom-flutter-108dc.firebaseio.com/$userId/cartItems/${item.id}.json?auth=$token');
    List<Product> catProducts = [];
    for (int i = 0; i < cartItems.length; i++) {
      if (item.id == cartItems[i].id) {
        cartItems[i].itemCount = 0;
        continue;
      }
      catProducts.add(cartItems[i]);
    }
    cartItems = catProducts;
    notifyListeners();
  }

  double totalCartAmount() {
    double currentAmount = 0.0;
    for (int i = 0; i < cartItems.length; i++) {
      currentAmount += cartItems[i].price * cartItems[i].itemCount;
    }
    amount = currentAmount;
    return amount;
  }

  Future<void> emptyCart() async {
    await http.delete('https://ecom-flutter-108dc.firebaseio.com/$userId/cartItems.json?auth=$token');
    for (int i = 0; i < cartItems.length; i++) {
      cartItems[i].itemCount = 0;
    }
    cartItems = [];
    notifyListeners();
  }

  void addToCart() {
    notifyListeners();
  }
}
