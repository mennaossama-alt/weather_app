import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'details_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart'; // ضفنا ده

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();

  void _searchWeather() async {
    final String city = _cityController.text.trim();
    if (city.isEmpty) return;
    FocusScope.of(context).unfocus();
    await Provider.of<WeatherProvider>(
      context,
      listen: false,
    ).fetchWeather(city);
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DetailsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings), // زر الإعدادات
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                hintText: "Enter City Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (_) => _searchWeather(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchWeather,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Get Weather"),
            ),
          ],
        ),
      ),
    );
  }
}
