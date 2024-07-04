import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherDetailsScreen extends StatefulWidget {
  final String city;

  const WeatherDetailsScreen({super.key, required this.city});

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() {
    Provider.of<WeatherProvider>(context, listen: false)
        .fetchWeather(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
        actions: [
          IconButton(
            onPressed: _fetchWeather,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProvider, child) {
            if (weatherProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (weatherProvider.weather == null) {
              return const Center(child: Text('Failed to load weather data.'));
            } else {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'City: ${widget.city}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Temperature: ${weatherProvider.weather!.temp} °C',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Condition: ${weatherProvider.weather!.description}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    Image.network(
                      'http://openweathermap.org/img/wn/${weatherProvider.weather!.icon}@2x.png',
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Humidity: ${weatherProvider.weather!.humidity} %',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Wind Speed: ${weatherProvider.weather!.windspeed} m/s',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
