import 'dart:convert';

class Weather {
  final double temperature;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final int humidity;
  final double windSpeed;
  final String description;
  final int weatherCode;
  final double uvIndex;
  final String location;

  Weather({
    required this.temperature,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.weatherCode,
    required this.uvIndex,
    this.location = 'Palakkad, Kerala',
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    final current = map['current'] ?? {};
    final daily = map['daily'] ?? {};

    return Weather(
      temperature: (current['temperature_2m'] ?? 0).toDouble(),
      feelsLike: (current['apparent_temperature'] ?? 0).toDouble(),
      minTemp: daily['temperature_2m_min'] != null && (daily['temperature_2m_min'] as List).isNotEmpty
          ? (daily['temperature_2m_min'][0]).toDouble()
          : 0,
      maxTemp: daily['temperature_2m_max'] != null && (daily['temperature_2m_max'] as List).isNotEmpty
          ? (daily['temperature_2m_max'][0]).toDouble()
          : 0,
      humidity: current['relative_humidity_2m'] ?? 0,
      windSpeed: (current['wind_speed_10m'] ?? 0).toDouble(),
      weatherCode: current['weather_code'] ?? 0,
      description: _getWeatherDescription(current['weather_code'] ?? 0),
      uvIndex: (current['uv_index'] ?? 0).toDouble(),
    );
  }

  static String _getWeatherDescription(int code) {
    // WMO Weather interpretation codes
    if (code == 0) return 'Clear sky';
    if (code <= 3) return 'Partly cloudy';
    if (code <= 48) return 'Foggy';
    if (code <= 67) return 'Rainy';
    if (code <= 77) return 'Snowy';
    if (code <= 82) return 'Rain showers';
    if (code <= 86) return 'Snow showers';
    if (code <= 99) return 'Thunderstorm';
    return 'Unknown';
  }

  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'feelsLike': feelsLike,
      'minTemp': minTemp,
      'maxTemp': maxTemp,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'description': description,
      'weatherCode': weatherCode,
      'uvIndex': uvIndex,
      'location': location,
    };
  }

  String toJson() => json.encode(toMap());
}
