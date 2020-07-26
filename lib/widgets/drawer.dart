import 'package:flutter/material.dart';

class DrawerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.orange,
                child: Center(
                  child: Text(
                    'SHOP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'moderno-bold',
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                child: ListTile(
                  onTap: () => Navigator.of(context).pushNamed('/ordersScreen'),
                  leading: Icon(Icons.shopping_basket, color: Colors.white),
                  title: Text(
                    'Your Orders',
                    style: TextStyle(color: Colors.white, fontFamily: 'moderno-medium', fontSize: 20),
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                child: ListTile(
                  onTap: () => Navigator.of(context).pushNamed('/updateScreen'),
                  leading: Icon(
                    Icons.shop,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Products',
                    style: TextStyle(color: Colors.white, fontFamily: 'moderno-medium', fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
