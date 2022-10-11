import 'package:equatable/equatable.dart';

class FWeather extends Equatable {
  const FWeather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final dynamic main;
  final dynamic description;
  final dynamic icon;

  @override
  List<Object?> get props => [
        id,
        main,
        description,
        icon,
      ];
  factory FWeather.fromJson(Map<String, dynamic> json) => FWeather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}