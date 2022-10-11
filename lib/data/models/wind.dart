import 'package:equatable/equatable.dart';

class Wind extends Equatable {
  const Wind({
    required this.speed,
    required this.deg,
  });

  final double speed;
  final int deg;

  @override
  List<Object?> get props => [
        speed,
        deg,
      ];

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"],
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
      };
}