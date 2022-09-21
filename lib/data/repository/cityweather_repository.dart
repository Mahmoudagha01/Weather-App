import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:weatherapp/data/API/weather_API.dart';
import 'package:weatherapp/data/models/forecast_weather.dart';

import '../models/city_weather.dart';

class CityWeatherRepository {
  final WeatherApi weatherApi;

  CityWeatherRepository(this.weatherApi);

  Future<Weather> getCityWeather({required String city}) async {
    final Weather weather = await weatherApi.getCityWeatherBySearch(city);

    final weatherMap = Weather.fromMap(weather.toMap());

    return weatherMap;
  }

  Future<ForecastWeather> getFiveDaysWeather({required String city}) async {
    final ForecastWeather weather= await weatherApi.getFiveDaysWeather(city);

    final weatherMap = ForecastWeather.fromMap(weather.toMap());
if (kDebugMode) {
        log('exchange rate information: $weatherMap');
      }
    return weatherMap;
  }
}
