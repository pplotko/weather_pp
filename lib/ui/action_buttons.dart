import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_pp/bloc/weather_bloc.dart';
import 'package:weather_pp/bloc/weather_event.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = context.read<WeatherBloc>();
    // final UserCubit userCubit = context.read<UserCubit>();
    return Container(
      padding: EdgeInsets.all(8),
      height: 60,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFF2196F3), Color(0xFFf9e3ce)],
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: Text('Load'),
            onPressed: () {
              weatherBloc.add(WeatherLoadEvent());
              // userCubit.fetchUsers();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
          ),
          SizedBox(width: 8.0),
          ElevatedButton(
            child: Text('Clear'),
            onPressed: () {
              weatherBloc.add(WeatherClearEvent());
              // userCubit.clearUsers();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
