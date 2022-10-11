import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/business_logic/weather_state.dart';

import 'package:weatherapp/data/repository/cityweather_repository.dart';

import '../data/models/weather.dart';

class CityWeatherCubit extends Cubit<CityWeatherState> {
  CityWeatherCubit({required this.cityWeatherRepository})
      : super(CityWeatherInitial());

  final CityWeatherRepository cityWeatherRepository;
  Weather? cityWeather;

  List<Weather> dataList = [];
 

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
      dataList.add(cityWeather!);
      emit(CityWeatherSuccess());
    }
  }

  void getCityWeather({required String city}) async {
   try {
    emit(CityWeatherloading());
        cityWeather = await cityWeatherRepository.getCityWeather(city: city);
        emit(CityWeatherSuccess());
   } catch (e) {
      emit(CityWeatherError());
   }
  
    
  }
  }


