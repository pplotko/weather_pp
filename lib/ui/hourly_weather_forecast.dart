import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_pp/model.dart';

class hourlyWeatherForecast extends StatelessWidget {
  const hourlyWeatherForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var current = context.watch<Model>().current;
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            height: 80,
            width: 100,
              child: Column(
                children: [
                  Text('Temp +1h'),
                  Text('${(current.hourly[0].temp-273).roundToDouble()}'),
                ],
              )
          ),
          SizedBox(
              height: 80,
              width: 100,
              child: Column(
                children: [
                  Text('Temp +2h'),
                  Text('${(current.hourly[1].temp-273).roundToDouble()}'),
                ],
              )
          ),
          SizedBox(
              height: 80,
              width: 100,
              child: Column(
                children: [
                  Text('Temp +3h'),
                  Text('${(current.hourly[2].temp-273).roundToDouble()}'),
                ],
              )
          ),
          SizedBox(
              height: 80,
              width: 100,
              child: Column(
                children: [
                  Text('Temp +4h'),
                  Text('${(current.hourly[3].temp-273).roundToDouble()}'),
                ],
              )
          ),
          SizedBox(
              height: 80,
              width: 100,
              child: Column(
                children: [
                  Text('Temp +5h'),
                  Text('${(current.hourly[4].temp-273).roundToDouble()}'),
                ],
              )
          ),
          SizedBox(
              height: 80,
              width: 100,
              child: Column(
                children: [
                  Text('Temp +6h'),
                  Text('${(current.hourly[5].temp-273).roundToDouble()}'),
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