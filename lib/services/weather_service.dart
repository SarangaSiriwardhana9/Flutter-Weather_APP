// Import necessary packages
import 'dart:convert';
import 'package:http/http.dart' as http;

// This class handles all weather-related API calls
class WeatherService {
  // API key for OpenWeatherMap
  final String apiKey;
  // Base URL for the OpenWeatherMap API
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  // Constructor that takes an API key
  WeatherService(this.apiKey);

  // Method to get current weather for a city
  Future<Map<String, dynamic>> getWeather(String city) async {
    // Construct the full URL for the API call
    final url = '$baseUrl/weather?q=$city&units=metric&appid=$apiKey';
    print('Fetching weather data from: $url');

    try {
      // Make the API call
      final response = await http.get(Uri.parse(url));
      print('Weather API Response status: ${response.statusCode}');
      print('Weather API Response body: ${response.body}');

      // If the call was successful, return the data
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // If not, throw an error
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      // If there's any error, print it and rethrow
      print('Error in getWeather: $e');
      rethrow;
    }
  }

  // Method to get weather forecast for a city
  Future<Map<String, dynamic>> getForecast(String city) async {
    // Construct the full URL for the API call
    final url = '$baseUrl/forecast?q=$city&units=metric&appid=$apiKey';
    print('Fetching forecast data from: $url');

    try {
      // Make the API call
      final response = await http.get(Uri.parse(url));
      print('Forecast API Response status: ${response.statusCode}');
      print('Forecast API Response body: ${response.body}');

      // If the call was successful, return the data
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // If not, throw an error
        throw Exception('Failed to load forecast data: ${response.statusCode}');
      }
    } catch (e) {
      // If there's any error, print it and rethrow
      print('Error in getForecast: $e');
      rethrow;
    }
  }
}
