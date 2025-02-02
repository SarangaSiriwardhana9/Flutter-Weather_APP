import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  WeatherService(this.apiKey);

  Future<Map<String, dynamic>> getWeather(String city) async {
    final url = '$baseUrl/weather?q=$city&units=metric&appid=$apiKey';
    print('Fetching weather data from: $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('Weather API Response status: ${response.statusCode}');
      print('Weather API Response body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getWeather: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getForecast(String city) async {
    final url = '$baseUrl/forecast?q=$city&units=metric&appid=$apiKey';
    print('Fetching forecast data from: $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('Forecast API Response status: ${response.statusCode}');
      print('Forecast API Response body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load forecast data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getForecast: $e');
      rethrow;
    }
  }
}
