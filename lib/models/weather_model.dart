class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;
  final String iconCode;
  final int timezone;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.iconCode,
    required this.timezone,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      sunrise: json['sys']['sunrise'] as int,
      sunset: json['sys']['sunset'] as int,
      iconCode: json['weather'][0]['icon'] ?? '',
      timezone: json['timezone'] as int,
    );
  }
}
