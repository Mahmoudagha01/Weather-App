import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:weatherapp/utilities/constants.dart';

import '../../utilities/http_error_handler.dart';
import '../../utilities/weather_exception.dart';

import '../models/weather.dart';

class WeatherApi {
  Future<Weather> getCityWeather(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kHostApi,
      path: '/data/2.5/forecast',
      queryParameters: {
        'q': city,
        'appid': kApiKey,
      },
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      } else {
        log(response.body);
        final responseBody = json.decode(response.body);

        if (responseBody.isEmpty) {
          throw WeatherException('Cannot get the weather of the city');
        }

        return Weather.fromJson(responseBody);
      }
    } catch (e) {
      rethrow;
    }
  }


}
