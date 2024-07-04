import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  final String description;
  final String icon;
  final double temp;
  final int pressure;
  final int humidity;
  final int windspeed;

  Weather({
    required this.description,
    required this.icon,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.windspeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
