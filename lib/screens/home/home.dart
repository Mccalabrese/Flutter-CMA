import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Boutique Candles')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('candles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (!snapshot.hasData) return CircularProgressIndicator();
          
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var candle = snapshot.data!.docs[index];
              return Card(
                child: Column(
                  children: [
                    Image.network(candle['image'] ?? 'https://via.placeholder.com/150'),
                    Text(candle['name'] ?? 'Candle Name'),
                    Text('\$${candle['price'] ?? '25'}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
