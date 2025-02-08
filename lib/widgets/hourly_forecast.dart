// Import necessary Flutter packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// This widget displays the hourly weather forecast
class HourlyForecast extends StatelessWidget {
  // List of forecast data
  final List<dynamic> forecast;

  // Constructor that requires forecast data
  const HourlyForecast({Key? key, required this.forecast}) : super(key: key);

  // This method builds the UI for our hourly forecast
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title for the forecast section
        const Text(
          'Hourly Forecast',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        // Horizontal scrollable list of hourly forecasts
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Display up to 24 hours of forecast
            itemCount: forecast.length > 24 ? 24 : forecast.length,
            itemBuilder: (context, index) {
              final hourlyForecast = forecast[index];
              final time = DateTime.fromMillisecondsSinceEpoch(
                  hourlyForecast['dt'] * 1000);
              final temp = hourlyForecast['main']['temp'].round();
              final icon = hourlyForecast['weather'][0]['icon'];

              return Card(
                color: Colors.white.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Display the time
                      Text(DateFormat('HH:mm').format(time),
                          style: const TextStyle(color: Colors.white)),
                      // Display the weather icon
                      Image.network(
                        'http://openweathermap.org/img/w/$icon.png',
                        width: 30,
                        height: 30,
                      ),
                      // Display the temperature
                      Text('$temp°C',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
