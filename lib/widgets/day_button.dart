import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/services/weather.dart';

/*
this class represents the buttons that are showed on the first screen (days
screen). It displays the date of the given day and when it is pressed it
navigates to the second screen (weather screen) with the info of the given day.
 */
class DayButton extends StatelessWidget {
  //to store the weather data that is passed from the DaysScreen
  final weatherData;
  //to store information about the dates of today and the next 4 days
  final List<DateTime> daysDateTime;
  //the number of day (starts from 0, so today is 0, tomorrow is 1 and so on...)
  final int dayNumber;

  //constructor to initialize those variables
  DayButton({this.weatherData, required this.daysDateTime, required this.dayNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      //the widget contains a button that has some decoration, displays information about the date of the day and some brief information about the weather in that day (min/max temperature and a weather icon).
      // ignore: deprecated_member_use
      child: TextButton(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          //
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      '${DateFormat('E').format(daysDateTime[dayNumber])}',
                      style: kDayNameTextStyle,
                    ),
                  ),
                  Text(
                    ' ${DateFormat('MMM').format(daysDateTime[dayNumber])},',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '${weatherData['list'][dayNumber * 8]['main']['temp_min'].toInt()}/${weatherData['list'][dayNumber * 8]['main']['temp_max'].toInt()}° ${Weather().getWeatherIcon(weatherData['list'][dayNumber * 8]['weather'][0]['id'])}',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WeatherScreen(
                        weatherData: weatherData,
                        daysDateTime: daysDateTime,
                        dayNumber: dayNumber,
                      )));
        },
      ),
    );
  }
}
