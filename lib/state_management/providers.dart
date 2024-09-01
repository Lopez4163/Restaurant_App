import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/restaurant.dart';

// Provider for loading the restaurant list
final restaurantListProvider = FutureProvider<List<Restaurant>>((ref) async {
  final data = await rootBundle.loadString('assets/restaurants.json');
  final List<dynamic> jsonResult = json.decode(data);
  return jsonResult
      .map((json) => Restaurant.fromJson(json as Map<String, dynamic>))
      .toList();
});

// StateProvider for managing the search query
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider to filter the restaurant list based on the search query
final filteredRestaurantListProvider = Provider<List<Restaurant>>((ref) {
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
  final restaurants = ref.watch(restaurantListProvider).asData?.value ?? [];

  if (searchQuery.isEmpty) {
    return restaurants;
  }

  return restaurants.where((restaurant) {
    final nameLower = restaurant.name.toLowerCase();
    final cuisineLower = restaurant.cuisine.toLowerCase();
    return nameLower.contains(searchQuery) ||
        cuisineLower.contains(searchQuery);
  }).toList();
});
