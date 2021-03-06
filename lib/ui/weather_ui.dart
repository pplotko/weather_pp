import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_pp/bloc/weather_bloc.dart';
import 'package:weather_pp/bloc/weather_state.dart';
import 'package:weather_pp/ui/daily_weather_forecast2.dart';
import 'package:weather_pp/ui/hourly_weather_forecast.dart';

class WeatherUI extends StatelessWidget {
  const WeatherUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        // create: (BuildContext context) => WeatherBloc(),
        value: BlocProvider.of<WeatherBloc>(context),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherEmptyState) {
              return const Center(
                child: Text(
                  'No data received. Press button "Load"',
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            }

            if (state is WeatherLoadingState) {
              return const Center(child:
                CircularProgressIndicator(color: Color(0xFFf9e3ce),));
            }

            if (state is WeatherLoadedState) {
              final iconUrl = 'http://openweathermap.org/img/w/'
                  '${state.loadedWeather.current.weather[0].icon}.png';

              String formatDateTime() {
                // var timeString = DateTime.now();
                //   print('Data Time Now:$timeString');
                var timeString = DateTime.fromMillisecondsSinceEpoch(
                    state.loadedWeather.current.dt.toInt() * 1000, isUtc: false).toIso8601String();
                print('timeString: $timeString');
                print('current.dt: ${state.loadedWeather.current.dt}');
                final formatter  = DateFormat('yyyy-MM-dd H:m:s');
                String formatedTime = formatter.format(DateTime.parse(timeString));
                // String formatted = formatter.format(now);
                print('Data Time Now2:$formatedTime');
                print('weekday: ${DateTime.now().weekday}');
                print('weekday from json: ${DateTime.fromMillisecondsSinceEpoch(
                    state.loadedWeather.current.dt.toInt() * 1000, isUtc: false).weekday}');
                return (formatedTime);
              }

              String getDayName(double date) {
                int dayNum = DateTime.fromMillisecondsSinceEpoch(
                    date.toInt() * 1000, isUtc: false).weekday;
                print('weekday: ${dayNum}');
                final now = DateTime.now();
                if (now.weekday == dayNum) {
                  return 'Today';
                } else {
                  final week = [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday',
                  ];
                  print('weekday [0]: ${week[dayNum-1]}');
                  return week[dayNum-1];
                }
              }

              return
                ListView(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[Color(0xFF2196F3), Color(0xFFf9e3ce)],
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(32, 20, 32, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_on,
                                    color: Color(0XFFFFFFFF),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10,),
                                  // Text('${current.name ?? '?????? ????????????'}',
                                  // Text('${state.loadedWeather.timezone ?? '?????? ????????????'}',
                                  Text(state.loadedPlace,
                                    style: const TextStyle(fontSize: 20, color: Color(0XFFFFFFFF)),
                                  ),
                                ],
                              ),
                              const Icon(Icons.settings,
                                color: Colors.black26,
                                size: 20,
                              ),
                            ],),
                          const SizedBox(height: 20,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('${state.loadedWeather.current.temp != null ? (state.loadedWeather.current.temp-273).roundToDouble(): '?????? ????????????' }',
                                        style: const TextStyle(fontSize: 32, color: Color(0XFFFFFFFF), fontWeight: FontWeight.w600,),
                                      ),
                                      const SizedBox(width: 10,),
                                      const Text('??C',
                                        style: TextStyle(fontSize: 32, color: Color(0XFFFFFFFF),fontWeight: FontWeight.w600,),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6,),
                                  Text('${state.loadedWeather.current.weather[0].main != null ? state.loadedWeather.current.weather[0].main : '?????? ????????????' } ',
                                    style: const TextStyle(fontSize: 24, color: Color(0XFFFFFFFF), fontWeight: FontWeight.w600,),
                                  ),
                                ],
                              ),

                              // Show current weather icon
                              Padding(
                                padding: EdgeInsets.only(right: 32.0),
                                // child: Icon(Icons.cloud,
                                //   color: Color(0XFFFFFFFF),
                                //   size: 90,
                                // ),
                                child: Image.network(
                                  iconUrl,
                                  scale: 0.5,
                                  loadingBuilder: (_, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (_, error, stackTrace) {
                                    print('$error $stackTrace');
                                    return Container(
                                      padding: EdgeInsets.only(top: 30, bottom: 10),
                                      child: Icon(
                                        Icons.signal_wifi_connected_no_internet_4,
                                        color: Colors.grey[600],
                                        size: 60,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],),
                          const SizedBox(height: 20,),
                          Row( //Time
                            children: [
                              Text('${formatDateTime()}',
                                style: const TextStyle(fontSize: 16, color: Color(0XFFFFFFFF),
                                  fontWeight: FontWeight.w400,),
                              ),
                            ],
                          ),
                          Text('${getDayName(state.loadedWeather.daily[0].dt)}',
                            style: const TextStyle(fontSize: 16, color: Color(0XFFFFFFFF),
                              fontWeight: FontWeight.w400,),
                          ),
                          const SizedBox(height: 16,),
                          Text('pressure: ${state.loadedWeather.current.pressure != null ? (state.loadedWeather.current.pressure): '?????? ????????????' } hPa',
                            style: const TextStyle(fontSize: 13, color: Color(0XFFFFFFFF), fontWeight: FontWeight.w400,),
                          ),
                          Text('humidity: ${state.loadedWeather.current.humidity != null ? (state.loadedWeather.current.humidity): '?????? ????????????' } %',
                            style: const TextStyle(fontSize: 13, color: Color(0XFFFFFFFF), fontWeight: FontWeight.w400,),
                          ),
                          Text('wind speed: ${state.loadedWeather.current.wind_speed != null ? (state.loadedWeather.current.wind_speed): '?????? ????????????' } m/s',
                            style: const TextStyle(fontSize: 13, color: Color(0XFFFFFFFF), fontWeight: FontWeight.w400,),
                          ),
                          const SizedBox(height: 40,),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Text('??oord: lon= ${state.loadedWeather./*coord.*/lon ?? '?????? ????????????'}, lat = ${state.loadedWeather./*coord.*/lat ?? '?????? ????????????'}')),
                          const SizedBox(height: 4,),
                    ],
                  ),
                ),
                  const hourlyWeatherForecast(),
                  const dailyWeatherForecast2(),
                ],
              );
            }

            if (state is WeatherErrorState) {
              return const Center(
                child: Text(
                  'Error fetching weather',
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        )
    );
  }
}
