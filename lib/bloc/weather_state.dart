
abstract class WeatherState {}

class WeatherEmptyState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  // List<dynamic> loadedUser;
  var loadedWeather;
  String loadedPlace;

  WeatherLoadedState({required this.loadedWeather, required this.loadedPlace}) : assert(loadedWeather != null, loadedPlace!= null);
}

class WeatherErrorState extends WeatherState {}