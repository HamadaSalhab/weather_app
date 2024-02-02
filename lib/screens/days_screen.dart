import 'package:flutter/material.dart';
import 'package:weather_app/widgets/day_button.dart';
import 'package:weather_app/services/weather.dart';

/*
this DayScreen widget is created as a stateful widget so that live updates
can be performed on this screen such as the loading animation and the buttons
when the data is fetched
*/
class DaysScreen extends StatefulWidget {
  @override
  _DaysScreenState createState() => _DaysScreenState();
}

class _DaysScreenState extends State<DaysScreen> {
  //to store the weather data that is fetched from the API
  var weatherData;
  //to store information about the dates of today and the next 4 days
  List<DateTime>? daysDateTime;
  //weather model in order to call the methods that are related to the weather
  Weather weatherModel = Weather();

  void getData() async {
    //requesting weather information so that the _data field in the weatherModel
    await weatherModel.updateData();

    /*
    setState() is used in order to recall the build method each
    time the values for weatherData and daysDateTime are updated
    so that the display can reflect the updated values
    */
    setState(() {
      weatherData = weatherModel.data;
      daysDateTime = weatherModel.getDateTimeInfo();
    });
  }

  @override
  void initState() {
    //to get the data on the start of the application
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          //setting the background image
          image: DecorationImage(
            image: AssetImage('images/weather_image.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: weatherData == null
            //if the weather data is not retrieved yet, a loading animation will be displayed instead of the buttons
            ? Center(child: CircularProgressIndicator())
            //if the weather data is retrieved, it will display 5 buttons representing information about today and the next 4 days
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //displaying the name of the city
                      Text(
                        'Forecast in ${weatherData['city']['name']}',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          //this listview contains 5 widgets, each one is a custom DayButton widget that contains the date of the day as well as some brief information about the weather (min and max temperature and weather icon). The reason of using listview is to make the list of the buttons scrollable to avoid overflowing if the screen size is too small to fit all the buttons.
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return DayButton(
                                weatherData: weatherData,
                                daysDateTime: daysDateTime!,
                                dayNumber: index,
                              );
                            },
                            itemCount: 5,
                          ),
                        ),
                      ),
                      //A button at the end of the page to refresh the page
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextButton(
                          //when we tap on this button it calls the function that updates the weather data.
                          onPressed: () async {
                            getData();
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.refresh,
                                size: 50.0,
                              ),
                              Text(
                                'Refresh',
                                style: TextStyle(fontSize: 20.0),
                              )
                            ],
                          ),
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
