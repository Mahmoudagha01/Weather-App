import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/business_logic/weather_cubit.dart';
import 'package:weatherapp/data/API/weather_API.dart';
import 'package:weatherapp/data/repository/cityweather_repository.dart';
import 'package:weatherapp/utilities/routes.dart';

import 'utilities/router.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CityWeatherCubit(
          cityWeatherRepository: CityWeatherRepository(WeatherApi())),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerate,
        initialRoute: AppRoutes.home,
      ),
    );
  }
}
