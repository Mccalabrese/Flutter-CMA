import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final cartItems = cartProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => cartProvider.clearCart(),
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems.values.elementAt(index);
                return ListTile(
                  leading: Image.network(
                    item.image,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.name),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => cartProvider.removeItem(item.id),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
