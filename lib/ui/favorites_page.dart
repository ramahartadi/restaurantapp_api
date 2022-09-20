import 'dart:io';

import 'package:restaurantapp_api/provider/database_provider.dart';
import 'package:restaurantapp_api/utils/result_state.dart';
import 'package:restaurantapp_api/widgets/card_restaurant.dart';
import 'package:restaurantapp_api/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';

  const FavoritesPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(favoritesTitle),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(favoritesTitle),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return CardRestaurant(restaurant: provider.favorites[index]);
            },
          );
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(provider.message),
            ),
          );
        } else if (provider.state == ResultState.error) {
          if (provider.message is SocketException) {
            return Center(
              child: Material(
                child: Text("Gagal menyambung ke Internet"),
              ),
            );
          } else {
            return Center(
              child: Material(
                child: Text(provider.message),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
