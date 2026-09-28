import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  // Open-Meteo: completely free, no API key required
  static const String _geocodingUrl =
      'https://geocoding-api.open-meteo.com/v1/search';
  static const String _weatherUrl =
      'https://api.open-meteo.com/v1/forecast';

  Future<WeatherModel> getWeatherByCity(String cityName) async {
    // Step 1: Convert city name → latitude & longitude
    final geoUri = Uri.parse(
      '$_geocodingUrl?name=${Uri.encodeComponent(cityName)}&count=1&language=vi&format=json',
    );

    final geoResponse = await http.get(geoUri);

    if (geoResponse.statusCode != 200) {
      throw Exception('Lỗi kết nối geocoding (${geoResponse.statusCode})');
    }

    final geoData = jsonDecode(geoResponse.body) as Map<String, dynamic>;
    final results = geoData['results'] as List<dynamic>?;

    if (results == null || results.isEmpty) {
      throw Exception('Không tìm thấy thành phố "$cityName"');
    }

    final place = results[0] as Map<String, dynamic>;
    final double lat = (place['latitude'] as num).toDouble();
    final double lon = (place['longitude'] as num).toDouble();
    final String resolvedName = place['name'] ?? cityName;
    final String? country = place['country'];
    final String displayName =
        country != null ? '$resolvedName, $country' : resolvedName;

    // Step 2: Fetch weather using coordinates
    final weatherUri = Uri.parse(
      '$_weatherUrl?latitude=$lat&longitude=$lon'
      '&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,weather_code,wind_speed_10m'
      '&timezone=auto',
    );

    final weatherResponse = await http.get(weatherUri);

    if (weatherResponse.statusCode != 200) {
      throw Exception('Lỗi khi tải dữ liệu thời tiết (${weatherResponse.statusCode})');
    }

    final weatherData =
        jsonDecode(weatherResponse.body) as Map<String, dynamic>;
    final current = weatherData['current'] as Map<String, dynamic>;

    return WeatherModel(
      cityName: displayName,
      temperature: (current['temperature_2m'] as num).toDouble(),
      feelsLike: (current['apparent_temperature'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).toInt(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      weatherCode: (current['weather_code'] as num).toInt(),
      isDay: (current['is_day'] as num).toInt() == 1,
    );
  }
}
