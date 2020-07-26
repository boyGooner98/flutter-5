import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> productList = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  List<Product> get productsList {
    return [...productList];
  }

  String token;
  String userId;
  Products(this.token, this.productList,this.userId);
  void toggleFavourite(Product product) {
    product.isFavourite = product.isFavourite ? false : true;
    notifyListeners();
  }

  Future<void> getProductsList() async {
    try {
      var response = await http.get('https://ecom-flutter-108dc.firebaseio.com/$userId/products.json?auth=$token');
      Map<String, Object> resposeData = json.decode(response.body) as Map<String, Object>;
      List<Product> tempList = [];
      resposeData.forEach((key, value) {
        Map<String, Object> product = resposeData[key];
        tempList.add(Product(
            id: key,
            title: product['title'],
            price: product['price'],
            description: product['description'],
            imageUrl: product['url']));
      });
      productList = tempList;
      return Future.value();
    } catch (err) {
      print(err);
    }
    // List<Product> tempList = [];
    // resposeData.forEach((key, value) {
    //   Map<String,Object> product = resposeData['key'];
    //   tempList.add(Product(id:product.id,))
    // });

    notifyListeners();
  }

  Future<void> addProduct(String key, String t, double p, String des, String url) async {
    try {
      final response = await http.post('https://ecom-flutter-108dc.firebaseio.com/$userId/products.json?auth=$token',
          body: json.encode({'title': t, 'price': p, 'description': des, 'url': url}));
      final productId = json.decode(response.body);
      Product product =
          new Product(id: productId['name'].toString(), title: t, price: p, description: des, imageUrl: url);
      productList.add(product);
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> updateProduct(String key, String t, double p, String des, String url) async {
    try {
      await http.patch('https://ecom-flutter-108dc.firebaseio.com/$userId/products/$key.json?auth=$token',
          body: json.encode({'title': t, 'price': p, 'description': des, 'url': url}));
      for (int i = 0; i < productList.length; i++) {
        if (productList[i].id == key) {
          productList[i].title = t;
          productList[i].description = des;
          productList[i].price = p;
          productList[i].imageUrl = url;
          break;
        }
      }
    } catch (err) {
      print(err);
    }
  }

  void removeProduct(String id) {
    productList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
