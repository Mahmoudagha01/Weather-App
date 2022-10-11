// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';

class MainClass extends Equatable {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  MainClass(this.temp, this.feelsLike, this.tempMin, this.tempMax,
      this.pressure, this.humidity);

  @override
  List<Object?> get props =>
      [temp, tempMax, tempMin, feelsLike, pressure, humidity];



 

  factory MainClass.fromJson(Map<String, dynamic> json) {
    return MainClass(
      json['temp'].toDouble() ,
      json['feels_like'].toDouble(),
      json['temp_min'].toDouble() ,
      json['temp_max'].toDouble() ,
      json['pressure'],
      json['humidity'] ,
    );
  }

   Map<String, dynamic>toJson() {
    return <String, dynamic>{
      'temp': temp,
      'feelsLike': feelsLike,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'pressure': pressure,
      'humidity': humidity,
    };
  }
}
