import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:weather_pp/service/current_weather/current_weather.dart';

class ApiClient {
  // final _httpClient = HttpClient();
  static const _apiKey="497d04b78cfab23e1679b18e620dd709";
  // late Language language;
  static const String FIVE_DAY_FORECAST = 'forecast';
  static const String CURRENT_WEATHER = 'weather';
  static const String ONE_CALL_WEATHER = 'onecall';
  static const int STATUS_OK = 200;

  ApiClient(_apiKey,) {
    var _httpClient = http.Client();
  }
  // apiClient(param0, param1);

  Future <Map<String, dynamic>> currentWeatherByLocation(double latitude, double longitude) async {
    Map<String, dynamic>? jsonResponse = await _sendRequest(ONE_CALL_WEATHER, /*CURRENT_WEATHER,*/ lat: latitude, lon: longitude);
    return jsonResponse!;
  }

  Future<Map<String, dynamic>?> _sendRequest(String tag, {double? lat, double? lon, String? cityName}) async {
    /// Build HTTP get url by passing the required parameters
    String url = _buildUrl(tag, cityName, lat, lon);
    /// Send HTTP get response with the url
    final response = await http.get(Uri.parse(url));

    /// Perform error checking on response:
    /// Status code 200 means everything went well
    if (response.statusCode == STATUS_OK) {
      Map<String, dynamic>? jsonBody = json.decode(response.body);
      return jsonBody;
    }

    /// The API key is invalid, the API may be down
    /// or some other unspecified error could occur.
    /// The concrete error should be clear from the HTTP response body.
    else {
      // throw OpenWeatherAPIException("The API threw an exception: ${response.body}");
    }
  }

  String _buildUrl(String tag, String? cityName, double? lat, double? lon) {
    String url = 'https://api.openweathermap.org/data/2.5/' + '$tag?';

    if (cityName != null) {
      url += 'q=$cityName&';
    } else {
      url += 'lat=$lat&lon=$lon&';
    }

    url += 'appid=$_apiKey&';
    url += 'lang=English}';
    // url += 'lang=${_languageCode[language]}';
    return url;
  }
}