import 'package:restaurantapp_api/common/styles.dart';
import 'package:restaurantapp_api/common/navigation.dart';
import 'package:restaurantapp_api/data/model/search_restaurant.dart';
import 'package:restaurantapp_api/ui/restaurant_detail_page.dart';
import 'package:flutter/material.dart';

class CardSearch extends StatelessWidget {
  final Restaurant restaurant;

  const CardSearch({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Text(restaurant.city),
        onTap: () => Navigation.intentWithData(
          RestaurantDetailPage.routeName,
          restaurant.id,
        ),
      ),
    );
  }
}
