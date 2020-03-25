import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("your Orders"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnap) {
          if (dataSnap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnap.error != null) {
              return Center(
                child: Text("something went wrong"),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemBuilder: (context, index) => OrderItem(
                    order: orderData.orders[index],
                  ),
                  itemCount: orderData.orders.length,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
