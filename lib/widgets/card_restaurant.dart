import 'package:restaurantapp_api/common/navigation.dart';
import 'package:restaurantapp_api/data/model/restaurant.dart';
import 'package:restaurantapp_api/ui/restaurant_detail_page.dart';
import 'package:restaurantapp_api/provider/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder(
        future: provider.isFavorited(restaurant.id),
        builder: (context, snapshot) {
          var isFavorited = snapshot.data ?? false;
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
              trailing: isFavorited
                  ? IconButton(
                      icon: const Icon(Icons.favorite),
                      color: Theme.of(context).colorScheme.tertiary,
                      onPressed: () => provider.removeFavorite(restaurant.id),
                    )
                  : IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: Theme.of(context).colorScheme.tertiary,
                      onPressed: () => provider.addFavorite(restaurant),
                    ),
              onTap: () => Navigation.intentWithData(
                RestaurantDetailPage.routeName,
                restaurant.id,
              ),
            ),
          );
        },
      );
    });
  }
}
