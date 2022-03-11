import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather_pp/service/current_weather/current_weather.dart';
import 'package:weather_pp/service/onecall_weather/onecall_weather.dart';

class Model extends ChangeNotifier{
  bool isButtonPressed = false;
  bool firstTime = true;
  late double positionLatitude,
      positionLongitude;
  var current;
  // weatherNow,

  void firstTimeCall(){
    firstTime = false;
    defaultWeatherWidget();
    print('firstTime:$firstTime');
    notifyListeners();
  }

  void buttonPressed(currentPosition, forecast){
    isButtonPressed = !isButtonPressed;
    positionLatitude = currentPosition.latitude;
    positionLongitude = currentPosition.longitude;
    print('forecast from model: $forecast');
    currentWeatherWidget(forecast);
  }

  void defaultWeatherWidget(){
    Map<String, dynamic> jsonTemp = jsonDecode(jsonStringCurrentWeather);
    print("DefaultCurrentWeather: ${jsonTemp}");
    current = decode(jsonTemp);
    // print('current.name in DefaultWeatherWidget(): ${current.name}');
    print('current.name in DefaultWeatherWidget(): ${current.timezone}');
    notifyListeners();
    // return current;
  }

  void currentWeatherWidget(fiveDayForecast) {
    print("fiveDayForecast: ${fiveDayForecast}");
    current = decode(fiveDayForecast);
    notifyListeners();
  }

  decode(myForecast) {
    print('cjsonDecode $json');
    // CurrentWeather current = CurrentWeather.fromJson(myForecast);
    OneCallWeather current = OneCallWeather.fromJson(myForecast);
    // print('current.name: ${current.name}');
    // print('current.temp: ${(current.main.temp-273)} deg.C');
    // notifyListeners();
  return current;
  }


}
