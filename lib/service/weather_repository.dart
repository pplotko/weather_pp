import 'package:weather_pp/service/weather_api_provider.dart';

class WeathersRepository {
  final WeatherProvider _weathersProvider = WeatherProvider();
  Future getAllWeathers() => _weathersProvider.fetchWeather();
  Future <String> getPlace() => _weathersProvider.fetchPlace();
  // Future<List<User>> getAllUsers() => _usersProvider.getUser();
}