import 'package:http/http.dart' as http;
import 'dart:convert';

/*
this class contains the properties and methods that are used in order to
perform the operations that are related to the internet (calling the API and
getting the response data).
 */
class NetworkHelper {
  //stores the URL
  final String url;
  //initializing new objects with URL
  NetworkHelper(this.url);

  //this method calls the API URL using the http package, decodes the response body, decodes it using jsonDecode and returns it
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    print('Getting data...');
    print('Response code is: ${response.statusCode}');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }
}
