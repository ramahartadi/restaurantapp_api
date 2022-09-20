import 'dart:async';

import 'package:restaurantapp_api/data/api/api_service.dart';
import 'package:restaurantapp_api/data/model/search_restaurant.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String query;

  SearchRestaurantProvider({required this.apiService, required this.query}) {
    _fetchSearchRestaurant(query);
  }

  late SearchRestaurantsResult _restaurantsResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  SearchRestaurantsResult? get result => _restaurantsResult;

  ResultState get state => _state;

  Future<dynamic> _fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantSearch(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
