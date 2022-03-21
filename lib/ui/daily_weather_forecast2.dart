import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_pp/model.dart';

class dailyWeatherForecast extends StatelessWidget {
  const dailyWeatherForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var current = context.watch<Model>().current;
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 60,
            width: 100,
              child: Column(
                children: [
                  Text('+1 Day'),
                  Text('${(current.daily[0].temp.day-273).roundToDouble()}'),
                ],
              )
          ),
          SizedBox(
              height: 60,
              width: 100,
              child: Column(
                children: [
                  Text('+2 Day'),
                  Text('${(current.daily[1].temp.day-273).roundToDouble()}'),
                ],
              )
          ),
          SizedBox(
              height: 60,
              width: 100,
              child: Column(
                children: [
                  Text('+3 Day'),
                  Text('${(current.daily[2].temp.day-273).roundToDouble()}'),
                ],
              )
          ),
          SizedBox(
              height: 60,
              width: 100,
              child: Column(
                children: [
                  Text('+4 Day'),
                  Text('${(current.daily[3].temp.day-273).roundToDouble()}'),
                ],
              )
          ),
          SizedBox(
              height: 60,
              width: 100,
              child: Column(
                children: [
                  Text('+5 Day'),
                  Text('${(current.daily[4].temp.day-273).roundToDouble()}'),
                ],
              )
          ),
          SizedBox(
              height: 60,
              width: 100,
              child: Column(
                children: [
                  Text('+6 Day'),
                  Text('${(current.daily[5].temp.day-273).roundToDouble()}'),
                ],
              )
          ),
        ],
      ),
    );
  }
}

// public static decimal RoundUp(decimal number, int digits)
// {
//   var factor = Convert.ToDecimal(Math.Pow(10, digits));
//   return Math.Ceiling(number * factor) / factor;
// }