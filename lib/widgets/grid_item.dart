import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';

class GridItem extends StatelessWidget {
  final Product griditem;
  GridItem(this.griditem);
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final cartProvider = Provider.of<Cart>(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Navigator.of(context).pushNamed('/productInfoScreen', arguments: {'item': griditem}),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Container(
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  griditem.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.noRepeat,
                ),
              ),
              Positioned(
                top: 130,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () => productsProvider.toggleFavourite(griditem),
                          icon: Icon(
                            griditem.isFavourite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.orange,
                          ),
                        ),
                        Text(griditem.title, style: TextStyle(color: Colors.white, fontSize: 10)),
                        IconButton(
                          onPressed: () {
                            cartProvider.addItem(griditem);
                            Scaffold.of(context).removeCurrentSnackBar();
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Item added to Cart~!!',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.green,
                              elevation: 10,
                              duration: Duration(seconds: 1),
                            ));
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.orange,
                          ),
                          iconSize: 20,
                        )
                      ],
                    ),
                  ),
                  width: 178,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
