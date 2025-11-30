import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String _errorMessage = '';
  List<String> _favorites = [];

  // متغير للوحدة: لو true يبقى سيليزيوس، لو false يبقى فهرنهايت
  bool _isCelsius = true;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<String> get favorites => _favorites;
  bool get isCelsius => _isCelsius;

  final WeatherService _service = WeatherService();

  WeatherProvider() {
    loadFavorites();
  }

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _weather = await _service.getWeather(cityName);
      _errorMessage = '';
    } catch (e) {
      _weather = null;
      _errorMessage = "City not found or connection error";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(String cityName) async {
    if (_favorites.contains(cityName)) {
      _favorites.remove(cityName);
    } else {
      _favorites.add(cityName);
    }
    notifyListeners();
    _saveFavoritesToPrefs();
  }

  bool isFavorite(String cityName) {
    return _favorites.contains(cityName);
  }

  // دالة تغيير الوحدة
  void toggleUnit() {
    _isCelsius = !_isCelsius;
    notifyListeners();
  }

  Future<void> _saveFavoritesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favorites);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }
}
