import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/models/weather.dart';

// Weather provider
final weatherProvider = FutureProvider<Weather>((ref) async {
  final url = Uri.parse(
    '${AppConstants.weatherApiUrl}?'
    'latitude=${AppConstants.iitPalakkadLat}&'
    'longitude=${AppConstants.iitPalakkadLon}&'
    'current=temperature_2m,relative_humidity_2m,apparent_temperature,'
    'weather_code,wind_speed_10m,uv_index&'
    'daily=temperature_2m_max,temperature_2m_min&'
    'timezone=Asia/Kolkata',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Weather.fromMap(data);
  } else {
    throw Exception('Failed to load weather data');
  }
});

class WeatherContainer extends ConsumerWidget {
  const WeatherContainer({super.key});

  String _getUvIndexWarning(double uvIndex) {
    if (uvIndex < 3) return 'Low';
    if (uvIndex < 6) return 'Moderate';
    if (uvIndex < 8) return 'High';
    if (uvIndex < 11) return 'Very High';
    return 'Extreme';
  }

  Color _getUvIndexColor(double uvIndex) {
    if (uvIndex < 3) return Colors.green;
    if (uvIndex < 6) return Colors.yellow;
    if (uvIndex < 8) return Colors.orange;
    if (uvIndex < 11) return Colors.red;
    return Colors.purple;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: weatherAsync.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stack) => Center(
            child: Column(
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 8),
                Text(
                  'Failed to load weather',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          data: (weather) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    weather.location,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Temperature and description
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${weather.temperature.round()}°C',
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        weather.description,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    _getWeatherIcon(weather.weatherCode),
                    size: 64,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Weather details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _WeatherDetail(
                    icon: Icons.thermostat,
                    label: 'Feels like',
                    value: '${weather.feelsLike.round()}°C',
                  ),
                  _WeatherDetail(
                    icon: Icons.water_drop,
                    label: 'Humidity',
                    value: '${weather.humidity}%',
                  ),
                  _WeatherDetail(
                    icon: Icons.air,
                    label: 'Wind',
                    value: '${weather.windSpeed.round()} km/h',
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // UV Index
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getUvIndexColor(weather.uvIndex).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.wb_sunny,
                      color: _getUvIndexColor(weather.uvIndex),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'UV Index: ${weather.uvIndex.round()} - ${_getUvIndexWarning(weather.uvIndex)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: _getUvIndexColor(weather.uvIndex),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getWeatherIcon(int code) {
    if (code == 0) return Icons.wb_sunny;
    if (code <= 3) return Icons.cloud;
    if (code <= 48) return Icons.foggy;
    if (code <= 67) return Icons.water_drop;
    if (code <= 77) return Icons.ac_unit;
    if (code <= 82) return Icons.grain;
    if (code <= 99) return Icons.thunderstorm;
    return Icons.wb_cloudy;
  }
}

class _WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
