import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weather = weatherProvider.weather;

    // منطق التحويل: لو سيليزيوس خد الرقم زي ما هو، لو فهرنهايت حوله
    double displayTemp = weather != null ? weather.temperature : 0.0;
    String unit = "°C";

    if (!weatherProvider.isCelsius && weather != null) {
      displayTemp = (weather.temperature * 9 / 5) + 32; // معادلة التحويل
      unit = "°F";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Details"),
        actions: [
          if (weather != null)
            IconButton(
              icon: Icon(
                weatherProvider.isFavorite(weather.cityName)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                weatherProvider.toggleFavorite(weather.cityName);
              },
            ),
        ],
      ),
      body: weatherProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : weatherProvider.errorMessage.isNotEmpty
          ? Center(
              child: Text(
                weatherProvider.errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            )
          : weather == null
          ? const Center(child: Text("No Data Found"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    weather.cityName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.network(
                    'https://openweathermap.org/img/wn/${weather.iconCode}@4x.png',
                    width: 100,
                    height: 100,
                  ),

                  // عرض الحرارة المتغيرة
                  Text(
                    "${displayTemp.toStringAsFixed(1)} $unit",
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    weather.description,
                    style: const TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoCard(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: "${weather.humidity}%",
                      ),
                      _buildInfoCard(
                        icon: Icons.air,
                        label: "Wind",
                        value: "${weather.windSpeed} m/s",
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
