import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_flutter/providers/cart.dart';
import 'package:shopping_cart_flutter/providers/orders.dart';
import '../widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("your cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.title.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(
                    cart: cart,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (context, index) => ci.CartItem(
                    id: cart.items.values.toList()[index].id,
                    productId: cart.items.keys.toList()[index],
                    price: cart.items.values.toList()[index].price,
                    quantity: cart.items.values.toList()[index].quantity,
                    title: cart.items.values.toList()[index].title)),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;
  OrderButton({this.cart});
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('Order Now'),
      onPressed: widget.cart.totalAmount <= 0 || _isLoading
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(), widget.cart.totalAmount);
              widget.cart.clearCart();
              setState(() {
                _isLoading = false;
              });
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
