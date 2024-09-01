import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import '../../models/restaurant.dart';
import 'restaurant_details_screen.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  late Future<List<Restaurant>> _restaurants;
  String _searchQuery = "";
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _restaurants = loadRestaurants();
  }

  Future<List<Restaurant>> loadRestaurants() async {
    final data = await rootBundle.loadString('assets/restaurants.json');
    final List<dynamic> jsonResult = json.decode(data);
    return jsonResult.map((json) => Restaurant.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '🍽️',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(width: 4),
              Text('Top Restaurants Near You'),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();

                _debounce = Timer(const Duration(milliseconds: 150), () {
                  setState(() {
                    _searchQuery = value;
                  });
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter Restaurant Name or Cuisine...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: _restaurants,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No restaurants found.'));
          } else {
            final restaurants = snapshot.data!.where((restaurant) {
              final queryLower = _searchQuery.toLowerCase();
              final nameLower = restaurant.name.toLowerCase();
              final cuisineLower = restaurant.cuisine.toLowerCase();
              return nameLower.contains(queryLower) ||
                  cuisineLower.contains(queryLower);
            }).toList();

            if (restaurants.isEmpty) {
              return const Center(child: Text('No restaurants found.'));
            }

            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return ListTile(
                  title: Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    restaurant.cuisine,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailsScreen(
                          restaurant: restaurant,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
