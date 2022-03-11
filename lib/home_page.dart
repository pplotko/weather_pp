import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_pp/model.dart';
import 'package:weather_pp/service/api_client/api_client.dart';
import 'package:weather_pp/service/location_checked.dart';
import 'package:weather_pp/ui/current_date_ui.dart';
import 'package:weather_pp/ui/daily_weather_forecast.dart';
import 'package:weather_pp/ui/hourly_weather_forecast.dart';
// import 'package:weather/weather.dart';
// import 'package:weather_pp/ui/current_weather_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

  @override
  void initState() {
    initState();

  }

class _HomePageState extends State<HomePage> {
  // Model.defaultWeatherWidget();
  @override
  Widget build(BuildContext context) {
    final model = context.read<Model>();
    var current = context.watch<Model>().current;
    var forecast;
    var currentPosition;
    // var firstTime=true;
    if (model.firstTime) model.firstTimeCall();
    // if (current == null) {model.DefaultWeatherWidget();};
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: const Text("Location"),),
        backgroundColor: Colors.amber[50],
        floatingActionButton: Builder(builder: (BuildContext context) {
          return FloatingActionButton(
            child: const Icon(Icons.refresh),
            tooltip: "Refresh",
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            heroTag: null,
            elevation: 7.0,
            highlightElevation: 14.0,
            onPressed: () async {
              currentPosition = await LocationChecked().getLocation();
              forecast = await fetchWeather();
              print('123');
              model.buttonPressed(currentPosition, forecast);
            },
            mini: false,
            shape: const CircleBorder(),
            isExtended: false,
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        body: Container(
          // constraints: BoxConstraints.tightFor(width: double.infinity, height: double.infinity),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF2196F3), Color(0xFFf9e3ce)],
            ),
          ),
          child: ListView(
            children: [
              const CurrentDateUiWidget(),
              // hourlyWeatherForecast(),
              SizedBox(
                child: hourlyWeatherForecast(),
                height: 100,
                // width: 400,
              ),
              SizedBox(
                child: dailyWeatherForecast(),
                height: 600,
                // width: 400,
              ),
            ],
          ),
        ),

      ),
    );
  }
}

Future  fetchWeather() async {
  const String _apiKey = '497d04b78cfab23e1679b18e620dd709';
  var location;
  var la;

  try {
    location = await LocationChecked().getLocation();
    print('location: $location');
    la = location.latitude!;
    print('location.latitude: $la');
    }
    catch (error) {
      return print('$error ${StackTrace.current}');
    }
    try {
      var apiClient = ApiClient(_apiKey);
      Map<String, dynamic> fiveDayForecast = await apiClient.currentWeatherByLocation(
      location.latitude!,
      location.longitude!,
    ).timeout(const Duration(seconds: 10));
      print('map json ${fiveDayForecast.toString}');
      return fiveDayForecast;
    } catch (error) {
        print('$error ${StackTrace.current}');
        return Future.error(error, StackTrace.current);
    }
}