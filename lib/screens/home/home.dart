import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../services/cart_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boutique Candles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => Navigator.pushNamed(context, '/aboutUs'),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('candles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (!snapshot.hasData) return const CircularProgressIndicator();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var candle = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/productDetails',
                    arguments: {
                      'image': candle['image'],
                      'name': candle['name'],
                      'price': candle['price'],
                      'description': candle['description'],
                      'burn_time': candle['burn_time'],
                      'scent_notes': candle['scent_notes'],
                      'size': candle['size'],
                      'id': snapshot.data!.docs[index].id
                    },
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.network(
                        candle['image'] ?? 'https://via.placeholder.com/150',
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Text(candle['name'] ?? 'Candle Name'),
                      Text('\$${candle['price'] ?? '25'}'),
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          context.read<CartProvider>().addItem(
                            snapshot.data!.docs[index].id,
                            candle['name'],
                            candle['image'],
                            candle['price'].toDouble(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${candle['name']} added to cart!')),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
