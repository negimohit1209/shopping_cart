import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_flutter/providers/products.dart';

import '../widgets/products_grid.dart';

enum FileterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
//    final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FileterOptions selectedValue) {
              setState(() {
                if (selectedValue == FileterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text("only favourite"),
                  value: FileterOptions.Favorites),
              PopupMenuItem(child: Text("show all"), value: FileterOptions.All)
            ],
          )
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
