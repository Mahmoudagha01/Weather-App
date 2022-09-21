
import 'package:equatable/equatable.dart';

class ForecastWeather extends Equatable {
  final String weatherStateMain;
  final String weatherStateDescription;
  final String weatherStateIcon;

  final double tempMin;
  final double tempMax;
  final double temp;
  final double feelsLike;
  final double speed;
  final int deg;
  final int humidity;

  final String dttxt;
   final List days;
  const ForecastWeather(
      {required this.weatherStateMain,
      required this.weatherStateDescription,
      required this.weatherStateIcon,

      required this.tempMin,
      required this.tempMax,
      required this.temp,
      required this.feelsLike,

      required this.speed,
      required this.deg,
      required this.humidity,
      required this.dttxt,
      required this.days
      });
  @override
  List<Object?> get props => [
        weatherStateMain,
        weatherStateDescription,
        weatherStateIcon,

        tempMin,
        tempMax,
        temp,
        feelsLike,

        speed,
        deg,
        humidity,
        dttxt,days
      ];
  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weather = json['weather'][0];
    final wind = json["wind"];
    return ForecastWeather(
        weatherStateMain: weather['main'],
        weatherStateDescription: weather['description'],
        weatherStateIcon: weather['icon'],
       days: json["list"],
        tempMin: main['temp_min'].toDouble(),
        tempMax: main['temp_max'].toDouble(),
        temp: main['temp'].toDouble(),
        humidity: main["humidity"].toInt(),
        feelsLike: main['feels_like'].toDouble(),

        speed: wind["speed"].toDouble(),
        deg: wind['deg'].toInt(),
        dttxt: json["dt_txt"],
        );
  }
  factory ForecastWeather.initial() => const ForecastWeather(

        weatherStateMain: '',
        weatherStateDescription: '',
        weatherStateIcon: '',
     days: [],
        tempMin: 0.0,
        tempMax: 0.0,
        temp: 0.0,
        feelsLike: 0.0,

        speed: 0.0,
        deg: 0,
        humidity:0,
        dttxt: ""
      );

  @override
  bool get stringify => true;
    Map<String, dynamic> toMap() {
    return {

      'weatherStateMain': weatherStateMain,
      'weatherStateDescription': weatherStateDescription,
      'weatherStateIcon': weatherStateIcon,
"days":days,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'temp': temp,
      'feelsLike': feelsLike,

      "speed":speed,
      "deg":deg,
      "humidity":humidity,
"dttxt":dttxt
    };
  }
   factory ForecastWeather.fromMap(Map<String, dynamic> map) {
    return ForecastWeather(

      weatherStateMain: map['weatherStateMain'] ?? '',
      weatherStateDescription: map['weatherStateDescription'] ?? '',
      weatherStateIcon: map['weatherStateIcon'] ?? '',
      days: map['list'] ?? [],
      tempMin: map['tempMin']?.toDouble() ?? 0.0,
      tempMax: map['tempMax']?.toDouble() ?? 0.0,
      temp: map['temp']?.toDouble() ?? 0.0,
      feelsLike: map['feelsLike']?.toDouble() ?? 0.0,

      speed: map["speed"]?.toDouble() ?? 0.0,
      deg: map["deg"]?.toInt()??0,
      humidity:map["humidity"]?.toInt()??0,
      dttxt: map["dt_txt"]?? ''
    );
  }
}

