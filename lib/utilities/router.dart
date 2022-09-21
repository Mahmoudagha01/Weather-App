import 'package:flutter/material.dart';
import 'package:weatherapp/data/models/city_weather.dart';
import 'package:weatherapp/presentation/screens/details.dart';
import 'package:weatherapp/presentation/screens/home.dart';
import 'package:weatherapp/presentation/screens/search.dart';
import 'package:weatherapp/utilities/routes.dart';



Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return MaterialPageRoute(builder: (context) => Home());

    case AppRoutes.details:
      final cityDetails = settings.arguments as Weather;
      return MaterialPageRoute(
        builder: (context) => Details(weather: cityDetails,),
      );
    case AppRoutes.search:
      return MaterialPageRoute(
        builder: (context) => Search(),
      );
    default:
      return MaterialPageRoute(builder: ((context) => Home()));
  }
}
