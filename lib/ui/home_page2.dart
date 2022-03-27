import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:provider/provider.dart';
import 'package:weather_pp/bloc/weather_bloc.dart';
import 'package:weather_pp/model.dart';
import 'package:weather_pp/service/api_client/api_client.dart';
import 'package:weather_pp/service/location_checked.dart';
import 'package:weather_pp/service/weather_repository.dart';
import 'package:weather_pp/ui/action_buttons.dart';
import 'package:weather_pp/ui/current_date_ui.dart';
import 'package:weather_pp/ui/daily_weather_forecast.dart';
import 'package:weather_pp/ui/hourly_weather_forecast.dart';
import 'package:weather_pp/ui/weather_ui.dart';

class HomePage2 extends StatelessWidget {
  final weatherRepository = WeathersRepository();

  HomePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider <WeatherBloc>(
      create: (context) => WeatherBloc(weatherRepository),
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text('Weather'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // ActionButtons(),
            Expanded(child: WeatherUI()),
            ActionButtons(),
          ],
        ),
      ),
    );
  }
}