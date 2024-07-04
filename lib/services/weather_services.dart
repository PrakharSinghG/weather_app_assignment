import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather.dart';

class WeatherService {
  static const String _apiKey = 'f8d965baa0c8026e51f8a55da42e7394';
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(String city) async {
    final response = await http
        .get(Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson({
        'description': json['weather'][0]['description'],
        'icon': json['weather'][0]['icon'],
        'temp': json['main']['temp'],
        'pressure': json['main']['pressure'],
        'humidity': json['main']['humidity'],
        'windspeed': json['wind']['speed'],
      });
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
