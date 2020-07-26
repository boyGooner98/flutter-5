import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/products_screen.dart';
import './providers/products_provider.dart';
import './screens/product_info_screen.dart';
import './providers/cart_provider.dart';
import './screens/cart_screen.dart';
import './providers/orders_provider.dart';
import './screens/order_screen.dart';
import './screens/products_update_screen.dart';
import './screens/add_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) =>
                Products(auth.token, previousProducts == null ? [] : previousProducts.productList,auth.userId),
            create: (BuildContext context) {},
          ),
          ChangeNotifierProxyProvider<Auth, Cart>(
            create: (BuildContext context) {},
            update: (context, auth, previous) => Cart(auth.token, previous == null ? [] : previous.cartItems,auth.userId),
          ),
          ChangeNotifierProxyProvider<Auth,Orders>(
            create: (BuildContext context) {},update: (context, auth, previous) =>Orders(auth.token,previous == null?[]:previous.orders,auth.userId) ,
          ),
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) => MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.orange,
                accentColor: Colors.yellow[700],
                backgroundColor: Colors.blue[100],
                fontFamily: 'moderno-medium',
                floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.green),
                appBarTheme: AppBarTheme(
                  elevation: 10,
                  textTheme: TextTheme(title: TextStyle(color: Colors.white, fontFamily: 'moderno-bold', fontSize: 30)),
                ),
              ),
              home: auth.isAuthenticated ? ProuductsScreen() : AuthScreen(),
              routes: {
                '/productInfoScreen': (ctx) => ProductInfoScreen(),
                '/cartScreen': (ctx) => CartScreen(),
                '/ordersScreen': (ctx) => OrdersScreen(),
                '/updateScreen': (ctx) => ProductUpdateScreen(),
                '/addProduct': (ctx) => AddProductScreen(),
              }),
        ));
  }
}
