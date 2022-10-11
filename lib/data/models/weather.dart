import 'package:equatable/equatable.dart';
import 'package:weatherapp/data/models/Listelement.dart';
import 'package:weatherapp/data/models/city.dart';


class Weather extends Equatable {
  const Weather({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  final String cod;
  final int message;
  final int cnt;
  final List<ListElement> list;
  final City city;

  @override
  List<Object?> get props => [
        cod,
        message,
        cnt,
        list,
        city,
      ];
  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        city: City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<dynamic>.from(list.map((x) => ListElement(
                dt: x.dt,
                main: x.main,
                weather: x.weather,
                wind: x.wind,
                visibility: x.visibility,
                dtTxt: x.dtTxt)
            .toJson())),
        "city": City(
          id: city.id,
          name: city.name,
          country: city.country,
        ).toJson(),
      };
}