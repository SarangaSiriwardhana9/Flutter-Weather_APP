import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyForecast extends StatelessWidget {
  final List<dynamic> forecast;

  const HourlyForecast({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hourly Forecast',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
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
                      Text(DateFormat('HH:mm').format(time),
                          style: const TextStyle(color: Colors.white)),
                      Image.network(
                        'http://openweathermap.org/img/w/$icon.png',
                        width: 30,
                        height: 30,
                      ),
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
