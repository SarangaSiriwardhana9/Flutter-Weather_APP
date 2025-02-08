// Import necessary Flutter packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// This widget displays the daily weather forecast
class DailyForecast extends StatelessWidget {
  // List of forecast data
  final List<dynamic> forecast;

  // Constructor that requires forecast data
  const DailyForecast({Key? key, required this.forecast}) : super(key: key);

  // This method builds the UI for our daily forecast
  @override
  Widget build(BuildContext context) {
    // Get the daily forecast from the raw forecast data
    final dailyForecast = _getDailyForecast(forecast);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title for the forecast section
        const Text(
          '7-Day Forecast',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        // List of daily forecasts
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dailyForecast.length,
          itemBuilder: (context, index) {
            final day = dailyForecast[index];
            return Card(
              color: Colors.white.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Display the day of the week
                    Text(DateFormat('EEE').format(day['date']),
                        style: const TextStyle(color: Colors.white)),
                    Row(
                      children: [
                        // Display the weather icon
                        Image.network(
                          'http://openweathermap.org/img/w/${day['icon']}.png',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 8),
                        // Display the temperature
                        Text('${day['temp'].round()}°C',
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // This method processes the raw forecast data into daily forecasts
  List<Map<String, dynamic>> _getDailyForecast(List<dynamic> forecast) {
    final Map<String, Map<String, dynamic>> dailyData = {};

    for (var item in forecast) {
      final date = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
      final dateString = DateFormat('yyyy-MM-dd').format(date);

      if (!dailyData.containsKey(dateString)) {
        dailyData[dateString] = {
          'date': date,
          'temp': item['main']['temp'],
          'icon': item['weather'][0]['icon'],
        };
      }
    }

    // Return the first 7 days of forecast
    return dailyData.values.take(7).toList();
  }
}
