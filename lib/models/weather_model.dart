class WeatherModel {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int weatherCode;
  final bool isDay;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.isDay,
  });

  // WMO weather code → description tiếng Việt
  String get description {
    if (weatherCode == 0) return 'Trời quang';
    if (weatherCode == 1) return 'Phần lớn quang';
    if (weatherCode == 2) return 'Có mây rải rác';
    if (weatherCode == 3) return 'Nhiều mây';
    if (weatherCode <= 49) return 'Sương mù';
    if (weatherCode <= 57) return 'Mưa phùn';
    if (weatherCode <= 67) return 'Mưa';
    if (weatherCode <= 77) return 'Tuyết';
    if (weatherCode <= 82) return 'Mưa rào';
    if (weatherCode <= 86) return 'Mưa tuyết';
    if (weatherCode <= 99) return 'Dông bão';
    return 'Không rõ';
  }

  // WMO weather code → emoji icon
  String get icon {
    if (weatherCode == 0) return isDay ? '☀️' : '🌙';
    if (weatherCode <= 2) return isDay ? '🌤️' : '🌤️';
    if (weatherCode == 3) return '☁️';
    if (weatherCode <= 49) return '🌫️';
    if (weatherCode <= 67) return '🌧️';
    if (weatherCode <= 77) return '❄️';
    if (weatherCode <= 82) return '🌦️';
    if (weatherCode <= 86) return '🌨️';
    if (weatherCode <= 99) return '⛈️';
    return '🌡️';
  }

  String get tempDisplay => '${temperature.round()}°C';
  String get feelsLikeDisplay => '${feelsLike.round()}°C';
}
