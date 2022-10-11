import 'package:flutter/material.dart';
import 'package:weatherapp/presentation/screens/details.dart';
import 'package:weatherapp/presentation/screens/home.dart';
import 'package:weatherapp/utilities/routes.dart';
import '../data/models/weather.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return MaterialPageRoute(builder: (context) => Home());

    case AppRoutes.details:
      final cityDetails = settings.arguments as Weather;
      return MaterialPageRoute(
        builder: (context) => Details(
          weather: cityDetails,
        ),
      );

    default:
      return MaterialPageRoute(builder: ((context) => Home()));
  }
}
