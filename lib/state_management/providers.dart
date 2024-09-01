import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/restaurant.dart'; // Adjusted path to go up one level from state_management to lib and then to models

// Provider to fetch the list of restaurants
final restaurantListProvider = FutureProvider<List<Restaurant>>((ref) async {
  final data = await rootBundle.loadString('assets/restaurants.json');
  final List<dynamic> jsonResult = json.decode(data);

  // Convert JSON to List<Restaurant>
  return jsonResult
      .map((json) => Restaurant.fromJson(json as Map<String, dynamic>))
      .toList();
});
