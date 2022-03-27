import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_pp/bloc/weather_bloc.dart';
import 'package:weather_pp/bloc/weather_state.dart';
// import 'package:weather_pp/model.dart';

class dailyWeatherForecast2 extends StatelessWidget {
  const dailyWeatherForecast2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final state = context.read<WeatherBloc>();
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
      BlocBuilder<WeatherBloc, WeatherState>(
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
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WeatherLoadedState) {
            return
            Container(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
              decoration: const BoxDecoration(
                // border: Border.all(
                //   width: 1,
                //   color: Color(0xFFf9e3ce),
                // ),
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFF2196F3), Color(0xFFf9e3ce)],
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0x33f9e3ce),
                  ),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(16.0),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1813173D),
                      offset: Offset(0, 4),
                      blurRadius: 64,
                      spreadRadius: 4,
                    ),
                  ],
                  // gradient: LinearGradient(
                  //   colors: <Color>[Color(0xFF2196F3), Color(0xFFf9e3ce)],
                  // ),
                  color: Color(0x33f9e3ce),
                ),
                height: 240,
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      SizedBox(
                        height: 30,
                        width: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                height: 25,
                                width: 80,
                                child: Text(getDayName(
                                    state.loadedWeather.daily[index].dt))),
                            Image.network(
                              'http://openweathermap.org/img/w/'
                                  '${state.loadedWeather.daily[index]
                                  .weather[0].icon}.png',
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
                                  padding: EdgeInsets.only(
                                      top: 4, bottom: 4),
                                  child: Icon(
                                    Icons
                                        .signal_wifi_connected_no_internet_4,
                                    color: Colors.grey[600],
                                    size: 60,
                                  ),
                                );
                              },
                            ),
                            Text('${(state.
                            loadedWeather.daily[index].temp.day - 273)
                                .roundToDouble()}°C'),
                          ],
                        ),
                      );
                  }
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
    );
  }
}

// public static decimal RoundUp(decimal number, int digits)
// {
//   var factor = Convert.ToDecimal(Math.Pow(10, digits));
//   return Math.Ceiling(number * factor) / factor;
// }