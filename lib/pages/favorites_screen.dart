import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final favorites = provider.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Cities")),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites yet!"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final city = favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    title: Text(city, style: const TextStyle(fontSize: 18)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        provider.toggleFavorite(city);
                      },
                    ),
                    onTap: () {
                      provider.fetchWeather(city);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailsScreen(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
