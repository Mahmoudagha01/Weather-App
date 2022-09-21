import 'package:weatherapp/data/models/city_weather.dart';

abstract class CityWeatherState {}

class CityWeatherInitial extends CityWeatherState {}
class CityWeatherloading extends CityWeatherState {}
class CityWeatherloaded extends CityWeatherState {
  
}

class CityWeatherError extends CityWeatherState {}
