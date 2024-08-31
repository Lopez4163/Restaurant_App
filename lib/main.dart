import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const RestaurantListScreen(),
    );
  }
}

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  late Future<List<Restaurant>> _restaurants;

  @override
  void initState() {
    super.initState();
    _restaurants =
        loadRestaurants(); // Load restaurant data when the widget is initialized
  }

  Future<List<Restaurant>> loadRestaurants() async {
    // Load the JSON data from the assets
    final data = await rootBundle.loadString('assets/restaurants.json');
    // Decode the JSON data
    final List<dynamic> jsonResult = json.decode(data);
    // Convert the JSON data into a list of Restaurant objects
    return jsonResult.map((json) => Restaurant.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'), // Title of the AppBar
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: _restaurants, // Future to fetch the restaurant data
        builder: (context, snapshot) {
          // Check the state of the Future
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display an error message if something goes wrong
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Display a message if no data is found
            return const Center(child: Text('No restaurants found.'));
          } else {
            // If data is available, display it in a ListView
            final restaurants = snapshot.data!;
            return ListView.builder(
              itemCount: restaurants.length, // Number of items in the list
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return ListTile(
                  title: Text(restaurant.name), // Display the restaurant name
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Restaurant {
  final int id;
  final String name;
  final String cuisine;

  Restaurant({required this.id, required this.name, required this.cuisine});

  // Factory method to create a Restaurant object from JSON data
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      cuisine: json['cuisine'],
    );
  }
}
