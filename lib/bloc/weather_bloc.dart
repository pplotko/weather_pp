import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_pp/bloc/weather_event.dart';
import 'package:weather_pp/bloc/weather_state.dart';
import 'package:weather_pp/service/onecall_weather/onecall_weather.dart';
import 'package:weather_pp/service/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeathersRepository weathersRepository;

  WeatherBloc(this.weathersRepository) : super(WeatherEmptyState()) {
    on<WeatherLoadEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        final OneCallWeather _loadedWeather = await weathersRepository.getAllWeathers();
        final String _loadedPlace = await weathersRepository.getPlace();
        emit(WeatherLoadedState(loadedWeather: _loadedWeather, loadedPlace:_loadedPlace));
      } catch (_) {
        emit(WeatherErrorState());
      }
    });
    on<WeatherClearEvent>((event, emit) async {
      emit(WeatherEmptyState());
    });
  }
}
