import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:weatherapp/utilities/constants.dart';

import '../../utilities/http_error_handler.dart';
import '../../utilities/weather_exception.dart';
import '../models/city_weather.dart';
import '../models/forecast_weather.dart';

class WeatherApi {
  Future<Weather> getCityWeatherBySearch(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kHostApi,
      path: '/data/2.5/weather',
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
        late final responseBody = json.decode(response.body);

        if (responseBody.isEmpty) {
          throw WeatherException('Cannot get the weather of the city');
        }

        return Weather.fromJson(responseBody);
      }
    } catch (e) {
      rethrow;
    }
  }

Future<ForecastWeather> getFiveDaysWeather(String city) async {
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

      late final responseBody = json.decode(response.body);

        return ForecastWeather.fromJson(responseBody);
      }
    } catch (e) {
      rethrow;
    }
  }

}
