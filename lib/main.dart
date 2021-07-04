import 'package:flutter/material.dart';
import 'package:my_weather/screens/days_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData.dark(),
      home: DaysScreen(),
    );
  }
}
