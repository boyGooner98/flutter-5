import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/grid_item.dart';
import '../widgets/drawer.dart';
import 'package:loading/loading.dart';

class ProuductsScreen extends StatefulWidget {
  @override
  _ProuductsScreenState createState() => _ProuductsScreenState();
}

class _ProuductsScreenState extends State<ProuductsScreen> {
  bool _init = false;
  bool _loading = true;
  @override
  void didChangeDependencies() async{
    if (!_init) {
      await Provider.of<Products>(context).getProductsList();
      setState(() {
        _loading = false;
      });
    }
    _init = true;
    super.didChangeDependencies();
  }

  Future<void> reloadPage(BuildContext context) async {
    Provider.of<Products>(context, listen: false).getProductsList();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.productsList;
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_basket),
              onPressed: () => Navigator.of(context).pushNamed('/cartScreen'),
            ),
          ],
        ),
        drawer: DrawerContainer(),
        body: _loading
            ? Center(
                child: Loading(
                  indicator: BallPulseIndicator(),
                  size: 100,
                  color: Colors.pink,
                ),
              )
            : RefreshIndicator(
                onRefresh: () => reloadPage(context),
                child: GridView(
                  padding: const EdgeInsets.all(5),
                  children: products.map((product) {
                    return GridItem(product);
                  }).toList(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              ));
  }
}
