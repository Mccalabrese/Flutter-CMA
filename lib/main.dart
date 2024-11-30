import 'package:flutter/material.dart';
import 'package:fresh_project/screens/home/home.dart'; // Adjust path based on your file structure
import 'package:fresh_project/screens/product_details/details.dart';
import 'package:provider/provider.dart';
import 'services/cart_provider.dart';
import 'package:fresh_project/screens/cart/cart.dart';
import 'package:fresh_project/screens/auth/auth.dart';
import 'package:fresh_project/screens/aboutUs/aboutUs.dart';



import 'package:firebase_core/firebase_core.dart';
void main() async {
  // Ensures the Flutter framework is initialized.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Main entry point for the app. Sets up routing and themes.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firestore Demo',
      theme: ThemeData(
        // Defines the theme for the entire app.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/productDetails': (context) => ProductDetailsScreen(),
        '/cart': (context) => CartScreen(),
        '/auth': (context) => AuthScreen(),
        '/aboutUs': (context) => AboutScreen(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // Home page widget with stateful behavior to manage its appearance.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Builds the UI for the home page.
    return Scaffold(
      appBar: AppBar(
        // Displays the app bar with the title.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Central layout widget that centers its child widget.
        child: Column(
          // Arranges children in a column.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
