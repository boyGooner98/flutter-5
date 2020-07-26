import '../models/product_model.dart';

class Order {
  final List<Product> cartItems;
  final double totalCost;
  final DateTime time;
  Order(this.cartItems, this.totalCost, this.time);
}
