import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';
  final String geoUrl = 'https://api.openweathermap.org/geo/1.0';

  WeatherService(this.apiKey);

  Future<Map<String, dynamic>> getWeather(double lat, double lon) async {
    final url = '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey';
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

  Future<Map<String, dynamic>> getForecast(double lat, double lon) async {
    final url =
        '$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=$apiKey';
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

  Future<Map<String, dynamic>> getWeatherByCity(String city) async {
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
      print('Error in getWeatherByCity: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getForecastByCity(String city) async {
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
      print('Error in getForecastByCity: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> searchCities(String query) async {
    if (query.length < 2) return [];

    final url = '$geoUrl/direct?q=$query&limit=5&appid=$apiKey';
    print('Searching cities: $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('City search API Response status: ${response.statusCode}');
      print('City search API Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> cities = json.decode(response.body);
        return cities.map((city) => city as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to search cities: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in searchCities: $e');
      rethrow;
    }
  }
}
