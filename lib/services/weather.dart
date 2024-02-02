import 'package:weather_app/services/networking.dart';
import 'package:weather_app/utilities/constants.dart';

//this class contains all the properties and methods that relates to the weather.
class Weather {
  //stores the weather data that is fetched from the API
  var _data;

  //getter for the _data property
  get data => _data;
  //setter for the _data property
  set data(value) {
    _data = value;
  }

  //uses NetworkHelper object to get the weather information, stores it in the _data property and returns it
  Future<dynamic> updateData() async {
    print('started updating data...');
    NetworkHelper networkHelper =
        NetworkHelper('$openWeatherMapURL$apyKey&units=metric');
    _data = await networkHelper.getData();

    print('...finished updating data');
    return _data;
  }

  //using the parse method inside DateTime, the daysDateTime list is updated with the dates of today and the next 4 days from the _data property
  List<DateTime> getDateTimeInfo() {
    List<DateTime> daysDateTime = [];
    daysDateTime.add(DateTime.parse(_data['list'][0]['dt_txt']));
    daysDateTime.add(DateTime.parse(_data['list'][8]['dt_txt']));
    daysDateTime.add(DateTime.parse(_data['list'][16]['dt_txt']));
    daysDateTime.add(DateTime.parse(_data['list'][24]['dt_txt']));
    daysDateTime.add(DateTime.parse(_data['list'][32]['dt_txt']));
    return daysDateTime;
  }

  //returns an icon that represents the weather status based on the condition
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
