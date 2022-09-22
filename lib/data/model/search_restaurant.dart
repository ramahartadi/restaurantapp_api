import 'dart:convert';
import 'package:restaurantapp_api/data/model/restaurant.dart';

SearchRestaurantsResult searchRestaurantResultFromJson(String str) =>
    SearchRestaurantsResult.fromJson(json.decode(str));

String searchRestaurantsResultToJson(SearchRestaurantsResult data) =>
    json.encode(data.toJson());

class SearchRestaurantsResult {
  SearchRestaurantsResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory SearchRestaurantsResult.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantsResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
