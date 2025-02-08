import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/weather_info_card.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/daily_forecast.dart';
import '../services/weather_service.dart';
import '../widgets/location_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService weatherService = WeatherService(
      'c60aebdca18be574a6d0d0618ae45f17'); // Replace with your API key
  Map<String, dynamic>? weatherData;
  Map<String, dynamic>? forecastData;
  String? errorMessage;
  String locationName = "Loading...";

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      setState(() {
        errorMessage = null;
      });

      // Request location permission
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Fetch weather and forecast data
      final weather = await weatherService.getWeather(
          position.latitude, position.longitude);
      final forecast = await weatherService.getForecast(
          position.latitude, position.longitude);

      setState(() {
        weatherData = weather;
        forecastData = forecast;
        locationName = weather['name']; // Update location name
      });
    } catch (e) {
      print('Error fetching weather data: $e');
      setState(() {
        errorMessage = 'Failed to fetch weather data. Please try again later.';
      });
    }
  }

  Future<void> _handleLocationSelected(
      String name, double lat, double lon) async {
    setState(() {
      locationName = name;
      weatherData = null;
      forecastData = null;
    });
    await _fetchWeatherDataByCoordinates(lat, lon);
  }

  Future<void> _fetchWeatherDataByCoordinates(double lat, double lon) async {
    try {
      setState(() {
        errorMessage = null;
      });

      // Fetch weather and forecast data for the selected coordinates
      final weather = await weatherService.getWeather(lat, lon);
      final forecast = await weatherService.getForecast(lat, lon);

      setState(() {
        weatherData = weather;
        forecastData = forecast;
        locationName = weather['name']; // Update location name
      });
    } catch (e) {
      print('Error fetching weather data: $e');
      setState(() {
        errorMessage = 'Failed to fetch weather data. Please try again later.';
      });
    }
  }

  Future<void> _fetchWeatherDataByCity(String city) async {
    try {
      setState(() {
        errorMessage = null;
      });

      // Fetch weather and forecast data for the selected city
      final weather = await weatherService.getWeatherByCity(city);
      final forecast = await weatherService.getForecastByCity(city);

      setState(() {
        weatherData = weather;
        forecastData = forecast;
        locationName = weather['name']; // Update location name
      });
    } catch (e) {
      print('Error fetching weather data: $e');
      setState(() {
        errorMessage = 'Failed to fetch weather data. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          LocationSearch(
            onLocationSelected: _handleLocationSelected,
            weatherService: weatherService,
          ),
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
                          locationName,
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
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
