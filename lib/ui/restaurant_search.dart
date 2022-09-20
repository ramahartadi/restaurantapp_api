import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurantapp_api/provider/search_resturant_provider.dart';
import 'package:restaurantapp_api/data/api/api_service.dart';
import 'package:restaurantapp_api/widgets/card_search.dart';
import 'package:provider/provider.dart';

class SearchRestaurant extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) =>
          SearchRestaurantProvider(apiService: ApiService(), query: query),
      child: Consumer<SearchRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result!.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.result!.restaurants[index];
                return CardSearch(restaurant: restaurant);
              },
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else if (state.state == ResultState.error) {
            if (state.message is SocketException) {
              return Center(
                child: Material(
                  child: Text("Gagal menyambung ke Internet"),
                ),
              );
            } else {
              return Center(
                child: Material(
                  child: Text("Gagal menyambung ke Internet"),
                ),
              );
            }
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Maukkan kata kunci'),
    );
  }
}
