import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_pp/model.dart';
import 'package:intl/intl.dart';
import 'package:weather_pp/ui/hourly_weather_forecast.dart';

class CurrentDateUiWidget extends StatelessWidget {
  const CurrentDateUiWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var current = context.watch<Model>().current;
    // final model = context.read<Model>();
    // model.DefaultWeatherWidget();

    String formatDateTime() {
      // var timeString = DateTime.now();
      //   print('Data Time Now:$timeString');
        var timeString = DateTime.fromMillisecondsSinceEpoch(
            current.current.dt.toInt() * 1000, isUtc: false).toIso8601String();
        print('timeString: $timeString');
        print('current.dt: ${current.current.dt}');
        final formatter  = DateFormat('yyyy-MM-dd H:m:s');
        String formatedTime = formatter.format(DateTime.parse(timeString));
        // String formatted = formatter.format(now);
        print('Data Time Now2:$formatedTime');
      return (formatedTime);
    }

    if (current == null) { return const Padding(
      padding: EdgeInsets.only(top: 50),
      child: Center(child: CircularProgressIndicator()),
    );
    } else { final iconUrl = 'http://openweathermap.org/img/w/'
        '${current.current.weather[0].icon}.png';
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
          colors: <Color>[Color(0xFF2196F3), Color(0xFFf9e3ce)],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(32, 20, 20, 20),
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
                    // Text('${current.name ?? 'нет данных'}',
                    Text('${current.timezone ?? 'нет данных'}',
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
                        // Text('${current.main.temp != null ? (current.main.temp-273).roundToDouble(): 'нет данных' }',
                        Text('${current.current.temp != null ? (current.current.temp-273).roundToDouble(): 'нет данных' }',
                          style: const TextStyle(fontSize: 32, color: Color(0XFFFFFFFF), fontWeight: FontWeight.w600,),
                        ),
                        const SizedBox(width: 10,),
                        const Text('°C',
                          style: TextStyle(fontSize: 32, color: Color(0XFFFFFFFF),fontWeight: FontWeight.w600,),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6,),
                    // Text('${current.weather[0].main != null ? current.weather[0].main : 'нет данных' } ',
                    Text('${current.current.weather[0].main != null ? current.current.weather[0].main : 'нет данных' } ',
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
            const SizedBox(height: 16,),
            // Text('pressure: ${current.main.pressure != null ? (current.main.pressure): 'нет данных' }hPa',
            //   style: const TextStyle(fontSize: 13, color: Color(0XFFFFFFFF), fontWeight: FontWeight.w400,),
            // ),
            // Text('humidity: ${current.main.humidity != null ? (current.main.humidity): 'нет данных' }%',
            //   style: const TextStyle(fontSize: 13, color: Color(0XFFFFFFFF), fontWeight: FontWeight.w400,),
            // ),
            // Text('wind speed: ${current.wind.speed != null ? (current.wind.speed): 'нет данных' }m/s',
            //   style: const TextStyle(fontSize: 13, color: Color(0XFFFFFFFF), fontWeight: FontWeight.w400,),
            // ),
            const SizedBox(height: 40,),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text('Сoord: lon= ${current./*coord.*/lon ?? 'нет данных'}, lat = ${current/*coord.*/.lat ?? 'нет данных'}')),
            const SizedBox(height: 4,),
          ],
        ),
      );
  }
}}

