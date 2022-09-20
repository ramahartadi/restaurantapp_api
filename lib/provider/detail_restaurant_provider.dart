import 'dart:async';

import 'package:restaurantapp_api/data/api/api_service.dart';
import 'package:restaurantapp_api/data/model/detail_restaurant.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _fetchAllDetailRestaurant(id);
  }

  late DetailRestaurant _detailRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailRestaurant get result => _detailRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.restaurantDetail(id);
      if (detailRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = detailRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
