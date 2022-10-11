// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int id;
  final String name;
  final String country;
  
  const City({
    required this.id,
    required this.name,
    required this.country,
  });

  @override
  List<Object?> get props => [id, name, country];

  factory City.fromJson(Map<String, dynamic> json) =>
      City(id: json["id"], name: json["name"], country: json["country"]);
      
  Map<String, dynamic> toJson() => {"id": id, "name": name, "country": country};
}
