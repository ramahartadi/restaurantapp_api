import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:restaurantapp_api/data/model/restaurant.dart';
import 'package:restaurantapp_api/data/model/detail_restaurant.dart';
import 'package:restaurantapp_api/data/model/search_restaurant.dart';

class ApiService {
  Client? client;
  ApiService({this.client}) {
    client ??= Client();
  }

  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantsResult> topHeadlines() async {
    final response = await client!.get(Uri.parse('${baseUrl}list'));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<DetailRestaurant> restaurantDetail(String id) async {
    final response = await client!.get(Uri.parse("${baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail data restaurant');
    }
  }

  Future<SearchRestaurantsResult> restaurantSearch(String query) async {
    final response = await client!.get(Uri.parse('${baseUrl}search?q=$query'));
    if (response.statusCode == 200) {
      return SearchRestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
