import 'package:flutter/material.dart';
import 'package:my_weather/services/weather.dart';
import 'package:my_weather/utilities/constants.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatelessWidget {
  //to store the weather data such as temperature, humidity... etc
  final weatherData;
  //to store date and time information about the next 5 days
  final List<DateTime> daysDateTime;
  //to store the order of days (1st day is numbered as 0)
  final int dayNumber;

  //constructor to initialize the variables above
  WeatherScreen({this.weatherData, this.daysDateTime, this.dayNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            //background image
            image: AssetImage('images/weather_image.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //back button to return to the first screen (days screen)
                BackButton(),
                //displaying the date of the day info on the screen
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    '${DateFormat('EEEE').format(daysDateTime[dayNumber])}\n${daysDateTime[dayNumber].day}/${daysDateTime[dayNumber].month}/${daysDateTime[dayNumber].year}',
                    style: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.85)),
                  ),
                ),
                Expanded(
                  //The reason of using listview is to make the list scrollable to avoid overflowing if the screen size is too small to fit the two containers.
                  child: ListView(
                    children: [
                      //first box: contains the temperature, min/max temperature, an icon that represents the weather status as well as a written short weather description.
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          //decorating the container with color, borders and shadow
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      //displaying the temperature
                                      Text(
                                        '${weatherData['list'][dayNumber * 8]['main']['temp'].toInt()}°',
                                        style: kTempTextStyle,
                                      ),
                                      //displaying the min/max temperature
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          'Min: ${weatherData['list'][dayNumber * 8]['main']['temp_min'].toInt()}°\tMax: ${weatherData['list'][dayNumber * 8]['main']['temp_max'].toInt()}°',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      //displaying the icon that represents the weather status
                                      Text(
                                        '${Weather().getWeatherIcon(weatherData['list'][dayNumber * 8]['weather'][0]['id'])}',
                                        style: kConditionTextStyle,
                                      ),
                                      //displaying weather description
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          '${weatherData['list'][dayNumber * 8]['weather'][0]['description']}',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      //second box: contains additional information about the weather such as humidity, rain probability, cloudiness, wind speed and pressure.
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          //decorating the container with color, borders and shadow
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                //displaying humidity
                                Text(
                                  'Humidity: ${weatherData['list'][dayNumber * 8]['main']['humidity']}%',
                                  style: kWeatherInfoTextStyle,
                                ),
                                //displaying rain probability
                                Text(
                                  'Rain probability: ${weatherData['list'][dayNumber * 8]['pop']}%',
                                  style: kWeatherInfoTextStyle,
                                ),
                                //displaying cloudiness
                                Text(
                                  'Cloudiness: ${weatherData['list'][dayNumber * 8]['clouds']['all']}%',
                                  style: kWeatherInfoTextStyle,
                                ),
                                Text(
                                  'Wind speed: ${weatherData['list'][dayNumber * 8]['wind']['speed']} km/h',
                                  style: kWeatherInfoTextStyle,
                                ),
                                //displaying pressure
                                Text(
                                  'Pressure: ${weatherData['list'][dayNumber * 8]['main']['pressure']} mbar',
                                  style: kWeatherInfoTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
