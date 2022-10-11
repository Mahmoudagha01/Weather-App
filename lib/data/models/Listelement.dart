import 'package:equatable/equatable.dart';
import 'package:weatherapp/data/models/fweather.dart';
import 'package:weatherapp/data/models/mainclass.dart';
import 'package:weatherapp/data/models/wind.dart';


class ListElement extends Equatable {
  const ListElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.wind,
    required this.visibility,
    required this.dtTxt,
  });

  final int dt;
  final MainClass main;
  final List<FWeather> weather;
  final Wind wind;
  final int visibility;
  final DateTime dtTxt;

  @override
  List<Object?> get props => [
        dt,
        main,
        weather,
        wind,
        visibility,
        dtTxt,
      ];
  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        main: MainClass.fromJson(json["main"]),
        weather: List<FWeather>.from(
            json["weather"].map((x) => FWeather.fromJson(x))),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"],
        dtTxt: DateTime.parse(json["dt_txt"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main,
        "weather": List<dynamic>.from(weather.map((x) => FWeather(
                id: x.id,
                main: x.main,
                description: x.description,
                icon: x.icon)
            .toJson())),
        "wind": Wind(
          speed: wind.speed,
          deg: wind.deg,
        ).toJson(),
        "visibility": visibility,
        "dt_txt": dtTxt.toIso8601String(),
      };
}