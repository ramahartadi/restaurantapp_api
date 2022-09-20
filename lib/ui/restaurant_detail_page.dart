import 'dart:io';
import 'package:provider/provider.dart';
import 'package:restaurantapp_api/provider/detail_restaurant_provider.dart';
import 'package:restaurantapp_api/data/api/api_service.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(apiService: ApiService(), id: id),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant App'),
        ),
        body: SafeArea(
          child: Consumer<DetailRestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Hero(
                        tag: state.result.restaurant.pictureId,
                        child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/large/${state.result.restaurant.pictureId}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              state.result.restaurant.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: const Icon(Icons.location_on),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10),
                                  child: Text(
                                    state.result.restaurant.city,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Oxygen',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: const Icon(Icons.star_sharp),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10),
                                  child: Text(
                                    '${state.result.restaurant.rating}',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Oxygen',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Description',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state.result.restaurant.description,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(height: 10),
                            const Text(
                              'Menus',
                              style: TextStyle(
                                // color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const Text(
                              'Foods',
                            ),
                            SizedBox(
                              height: 50,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: state.result.restaurant.menus.foods
                                    .map((food) => Column(children: [
                                          //widget Image(assets/foods.png),
                                          Card(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(food.name),
                                          ))
                                        ]))
                                    .toList(),
                              ),
                            ),
                            const Text(
                              'Drinks',
                            ),
                            SizedBox(
                              height: 50,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: state.result.restaurant.menus.drinks
                                    .map((drink) => Column(children: [
                                          //widget Image(assets/drinks.png),
                                          Card(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(drink.name),
                                          ))
                                        ]))
                                    .toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
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
        ),
      ),
    );
  }
}
