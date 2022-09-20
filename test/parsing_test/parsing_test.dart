import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurantapp_api/data/api/api_service.dart';
import 'package:restaurantapp_api/data/model/restaurant.dart';
import 'parsing_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('Returns RestaurantsResult', () async {
    final client = MockClient();

    // Use Mockito to return a successful response when it calls the
    // provided http.Client.
    when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
        .thenAnswer((_) async => http.Response(
            '{"error":false,"message":"success","count":20,"restaurants":[]}',
            200));

    expect(await ApiService(client: client).topHeadlines(),
        isA<RestaurantsResult>());
  });
}
