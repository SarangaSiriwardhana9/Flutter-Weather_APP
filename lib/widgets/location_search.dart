import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class LocationSearch extends StatelessWidget {
  final Function(String, double, double) onLocationSelected;
  final WeatherService weatherService;

  const LocationSearch({
    Key? key,
    required this.onLocationSelected,
    required this.weatherService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        showSearch(
          context: context,
          delegate: _LocationSearchDelegate(weatherService: weatherService),
        ).then((result) {
          if (result != null) {
            onLocationSelected(result['name'], result['lat'], result['lon']);
          }
        });
      },
    );
  }
}

class _LocationSearchDelegate extends SearchDelegate<Map<String, dynamic>> {
  final WeatherService weatherService;

  _LocationSearchDelegate({required this.weatherService});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, {});
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.length < 2) {
      return Center(
        child: Text('Enter at least 2 characters to search'),
      );
    }

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: weatherService.searchCities(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No results found'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final city = snapshot.data![index];
              return ListTile(
                title: Text(city['name']),
                subtitle: Text('${city['state'] ?? ''}, ${city['country']}'),
                onTap: () {
                  close(context, city);
                },
              );
            },
          );
        }
      },
    );
  }
}
