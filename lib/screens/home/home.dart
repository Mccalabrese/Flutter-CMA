
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Boutique Candles')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Image.network('https://via.placeholder.com/150'),
                Text('Candle Name'),
                Text('\$25'),
              ],
            ),
          );
        },
      ),
    );
  }
}
