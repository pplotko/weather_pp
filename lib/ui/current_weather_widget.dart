// import 'dart:convert';
//
// // import 'package:current_weather_data/services/current_weather/current_weather.dart';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weather_pp/model.dart';
// import 'package:weather_pp/service/current_weather/current_weather.dart';
//
// class CurrentWeatherWidget extends StatelessWidget {
//   const CurrentWeatherWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     CurrentWeather curent;
//     // var myForecast = context.watch<Model>().weatherNow;
//     String myString ="";
//     return curent = decode(myForecast);
//   //   if (curent == true) {
//   //     myString = 'Current place: ${curent.name}';
//   //   } else {myString = 'Current place: поак нет данных';}
//   // return
//   //   Scaffold(body: Text(myString, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),));
//   }
//   decode(myForecast) {
//     final dynamic json = jsonDecode(myForecast);
//     CurrentWeather curent = CurrentWeather.fromJson(json);
//     print('curent.name: ${curent.name}');
//     print('curent.temp: ${curent.main.temp}');
//     return curent;
//   }
// }


const jsonStringCurrentWeather =
'''{
      "coord": {
        "lon": -122.08,
        "lat": 37.39
        },
      "weather": [
        {
          "id": 800,
          "main": "Clear",
          "description": "clear sky",
          "icon": "01d"
        }
      ],
      "base": "stations",
      "main": {
        "temp": 282.55,
        "feels_like": 281.86,
        "temp_min": 280.37,
        "temp_max": 284.26,
        "pressure": 1023,
        "humidity": 100
       },
      "visibility": 16093,
      "wind": {
        "speed": 1.5,
        "deg": 350
      },
      "clouds": {
        "all": 1
      },
      "dt": 1560350645,
      "sys": {
        "type": 1,
        "id": 5122,
        "message": 0.0139,
        "country": "US",
        "sunrise": 1560343627,
        "sunset": 1560396563
      },
      "timezone": -25200,
      "id": 420006353,
      "name": "Mountain View",
      "cod": 200
    }''';