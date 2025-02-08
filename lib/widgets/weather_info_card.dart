// Import necessary Flutter package
import 'package:flutter/material.dart';

// This widget displays the main weather information
class WeatherInfoCard extends StatelessWidget {
  // Weather details to display
  final String temperature;
  final String condition;
  final String feelsLike;
  final String humidity;
  final String windSpeed;

  // Constructor that requires all weather details
  const WeatherInfoCard({
    Key? key,
    required this.temperature,
    required this.condition,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
  }) : super(key: key);

  // This method builds the UI for our weather info card
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display the main temperature
            Text(
              temperature,
              style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            // Display the weather condition
            Text(
              condition,
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            // Display additional weather details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherDetail('Feels like', feelsLike),
                _buildWeatherDetail('Humidity', humidity),
                _buildWeatherDetail('Wind', windSpeed),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each weather detail
  Widget _buildWeatherDetail(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.white)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }
}
