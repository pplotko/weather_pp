import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_pp/home_page.dart';
import 'package:weather_pp/model.dart';
import 'package:weather_pp/ui/home_page2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider(
        create: (context) => Model(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage2(),
        ),
      );
}