import 'package:location/location.dart';
import 'package:weather_pp/service/api_client/api_client.dart';
import 'package:weather_pp/service/current_weather/current_weather.dart';
import 'package:weather_pp/service/location_checked.dart';
import 'package:weather_pp/service/onecall_weather/onecall_weather.dart';

class WeatherProvider {

  Future <LocationData> getLocation() async {
    LocationData location;
    double la;
    try {
      location = await LocationChecked().getLocation();
      print('location: $location');
      la = location.latitude!;
      print('location.latitude: $la');
      return location;
    }
    catch (error) {
      print('$error(ошибка получения локации) ${StackTrace.current}');
      return Future.error(error, StackTrace.current);
    }
  }

  Future <OneCallWeather> fetchWeather() async {
    const String _apiKey = '497d04b78cfab23e1679b18e620dd709';
    LocationData location = await getLocation();
    print('location.latitude = ${location}');
    try {
      var apiClient = ApiClient(_apiKey);
      Map<String, dynamic> onecallWeather = await apiClient.onecallWeatherByLocation(
          // 37.4219983,-122.084,
        location.latitude!,
        location.longitude!,
      ).timeout(const Duration(seconds: 10));
      final weather = OneCallWeather.fromJson(onecallWeather);
      print('weather ${weather.timezone}');
      return weather;
    } catch (error) {
      print('$error (ошибка получения данных погоды) ${StackTrace.current}');
      return Future.error(error, StackTrace.current);
    }
  }
  Future <String> fetchPlace () async {
    const String _apiKey = '497d04b78cfab23e1679b18e620dd709';
    LocationData location = await getLocation();
    print('location.latitude = ${location}');
    try {
      var apiClient = ApiClient(_apiKey);
      Map<String, dynamic> curentWeather = await apiClient.currentWeatherByLocation(
        // 37.4219983,-122.084,
        location.latitude!,
        location.longitude!,
      ).timeout(const Duration(seconds: 10));
      final currentWeather = CurrentWeather.fromJson(curentWeather);
      print('place ${currentWeather.name}');
      return currentWeather.name;
    } catch (error) {
      print('$error (ошибка получения данных погоды) ${StackTrace.current}');
      return Future.error(error, StackTrace.current);
    }
  }

}


// Future<List<OneCallWeather>> getWeather() async {
//   final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));
//
//   if (response.statusCode == 200) {
//     final List<dynamic> userJson = json.decode(response.body);
//     return userJson.map((json) => User.fromJson(json)).toList();
//   } else {
//     throw Exception('Error fetching users');
//   }
// }