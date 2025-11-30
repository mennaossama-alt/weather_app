import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const String apiKey = 'YOUR_API_KEY_HERE';

  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> getWeather(String cityName) async {
    final url = Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
