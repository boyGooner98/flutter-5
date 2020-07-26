import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/products_provider.dart';

class ProductUpdateScreen extends StatefulWidget {
  @override
  _ProductUpdateScreenState createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> availableProducts = Provider.of<Products>(context).productsList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Changes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/addProduct'),
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.88,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Image.network(
                              availableProducts[index].imageUrl,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        Text(availableProducts[index].title),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => Navigator.of(context).pushNamed('/addProduct', arguments: {
                            'id':availableProducts[index].id,
                            'title': availableProducts[index].title,
                            'price': availableProducts[index].price,
                            'description': availableProducts[index].description,
                            'imageurl': availableProducts[index].imageUrl,
                          }),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () =>
                              Provider.of<Products>(context, listen: false).removeProduct(availableProducts[index].id),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            itemCount: availableProducts.length,
          ),
        ),
      ),
    );
  }
}
