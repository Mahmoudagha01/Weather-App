import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/business_logic/weather_state.dart';

import 'package:weatherapp/data/models/forecast_weather.dart';
import 'package:weatherapp/data/repository/cityweather_repository.dart';

import '../data/models/city_weather.dart';

class CityWeatherCubit extends Cubit<CityWeatherState> {
  CityWeatherCubit({required this.cityWeatherRepository})
      : super(CityWeatherInitial());

  final CityWeatherRepository cityWeatherRepository;
  Weather? cityWeather;
  ForecastWeather? dayWeather;
  List<Weather> dataList = [];
  List daysList = [];
  Future<void> getCityWeather({required String city}) async {
    emit(CityWeatherloading());
    try {
      cityWeather = await cityWeatherRepository.getCityWeather(city: city);
      emit(CityWeatherloaded());
    } catch (e) {
      emit(CityWeatherError());
    }
  }

  void getTopCities() async {
    List<String> cities = [
      "cairo",
      "Alexandria",
      "mansoura",
      "Tanta",
      "qena",
      'zagazig',
      'ismailia',
      'fayoum'
    ];
    emit(CityWeatherloading());
    for (var c in cities) {
      cityWeather = await cityWeatherRepository.getCityWeather(city: c);

      final weatherMap = Weather.fromMap(cityWeather!.toMap());
      dataList.add(weatherMap);
      emit(CityWeatherloaded());
    }
  }

// void getFiveDaysWeather(
//       {required String city}) async {
//     dayWeather = (await cityWeatherRepository.getFiveDaysWeather(city: city)) as ForecastWeather?;
//     emit(CityWeatherloaded());

//   }
  void getFiveDaysWeather({required String city}) async {
    emit(CityWeatherloading());
    try {
      dayWeather = await cityWeatherRepository.getFiveDaysWeather(city: city);
      daysList = dayWeather!.days;
      print(daysList);
      emit(CityWeatherloaded());
    } catch (e) {
      emit(CityWeatherError());
    }
  }
}
