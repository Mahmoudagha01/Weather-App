
import 'package:weatherapp/data/API/weather_API.dart';
import '../models/weather.dart';

 class CityWeatherRepository {
  final WeatherApi weatherApi;

  CityWeatherRepository(this.weatherApi);

  Future<Weather> getCityWeather({required String city}) async {
    final Weather weather = await weatherApi.getCityWeather(city);
    return weather;
  }

}
