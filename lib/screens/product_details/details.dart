import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/cart_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the candle data passed as arguments
    final candle = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(candle['name'] ?? 'Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              candle['image'] ?? 'https://via.placeholder.com/150',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              candle['name'] ?? 'Candle Name',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${candle['price'] ?? '0.00'}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              candle['description'] ?? 'No description available.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            if (candle['scent_notes'] != null)
              Text(
                'Scent Notes: ${candle['scent_notes']}',
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            const SizedBox(height: 8),
            if (candle['size'] != null)
              Text(
                'Size: ${candle['size']}',
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 8),
            if (candle['burn_time'] != null)
              Text(
                'Burn Time: ${candle['burn_time']}',
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add the product to the cart
                context.read<CartProvider>().addItem(
                  candle['id'],  // Use the id from Firestore
                  candle['name'], 
                  candle['image'], 
                  candle['price'].toDouble(),
                );
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${candle['name']} added to cart!'),
                ));
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
