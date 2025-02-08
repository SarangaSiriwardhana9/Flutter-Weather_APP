// Import necessary Flutter packages and local files
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/weather_info_card.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/daily_forecast.dart';
import '../services/weather_service.dart';

// This is the main screen of our weather app
class HomeScreen extends StatefulWidget {
  // Constructor for HomeScreen
  const HomeScreen({Key? key}) : super(key: key);

  // Create the mutable state for this widget
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// This is the state for our HomeScreen
class _HomeScreenState extends State<HomeScreen> {
  // Create an instance of WeatherService with API key
  final WeatherService weatherService =
      WeatherService('c60aebdca18be574a6d0d0618ae45f17');
  // Variables to store weather and forecast data
  Map<String, dynamic>? weatherData;
  Map<String, dynamic>? forecastData;
  // Variable to store error message if any
  String? errorMessage;

  // This method is called when the widget is first created
  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  // Method to fetch weather data from the API
  Future<void> _fetchWeatherData() async {
    try {
      // Clear any previous error message
      setState(() {
        errorMessage = null;
      });

      // Fetch current weather and forecast data
      final weather = await weatherService.getWeather('New York');
      print('Weather data received: $weather');

      final forecast = await weatherService.getForecast('New York');
      print('Forecast data received: $forecast');

      // Update the state with new data
      setState(() {
        weatherData = weather;
        forecastData = forecast;
      });
    } catch (e) {
      // If there's an error, update the error message
      print('Error fetching weather data: $e');
      setState(() {
        errorMessage = 'Failed to fetch weather data. Please try again later.';
      });
    }
  }

  // This method builds the UI for our home screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchWeatherData,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E88E5), Color(0xFF64B5F6)],
          ),
        ),
        child: SafeArea(
          child: errorMessage != null
              ? Center(
                  child: Text(errorMessage!,
                      style: const TextStyle(color: Colors.white)))
              : weatherData == null
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white))
                  : ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          weatherData!['name'],
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          DateFormat('EEEE, MMMM d').format(DateTime.now()),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        WeatherInfoCard(
                          temperature:
                              '${weatherData!['main']['temp'].round()}°C',
                          condition: weatherData!['weather'][0]['main'],
                          feelsLike:
                              '${weatherData!['main']['feels_like'].round()}°C',
                          humidity: '${weatherData!['main']['humidity']}%',
                          windSpeed: '${weatherData!['wind']['speed']} m/s',
                        ),
                        const SizedBox(height: 20),
                        if (forecastData != null)
                          HourlyForecast(forecast: forecastData!['list']),
                        const SizedBox(height: 20),
                        if (forecastData != null)
                          DailyForecast(forecast: forecastData!['list']),
                      ],
                    ),
        ),
      ),
    );
  }
}
