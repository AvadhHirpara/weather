import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/src/Constant/api_urls.dart';
import 'package:weather/src/app.dart';
import 'package:http/http.dart' as http;

class HomeNotifier extends ChangeNotifier {
  Map<String, dynamic>? weatherData;

  double latitude = 0.0;
  double longitude = 0.0;

  double celsius = 0;
  double fahrenheit = 32;
  bool isCelsius = true;

  ///Check user location permission
  Future<bool> permissionCheck() async {
    final status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      getUserLocation();
      notifyListeners();
      return true;
    } else if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
    final result = await Permission.location.request();
    return result == PermissionStatus.granted;
  }

  ///Get user current location
  getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));
    latitude = position.latitude;
    longitude = position.longitude;
     getWeatherData(latitude,longitude);

    notifyListeners();
  }

  ///Convert temperature
  void convertTemperature(double value, bool isCelsius) {
    if (isCelsius) {
      // Convert Celsius to Fahrenheit
      fahrenheit = (value * 9 / 5) + 32;
    } else {
      // Convert Fahrenheit to Celsius
      celsius = (value - 32) * 5 / 9;
    }
    notifyListeners();
  }

  ///Call api get weather
  Future getWeatherData(double latitude, double longitude) async {
    final response = await http.get(Uri.parse('${ApiUrls.baseUrl}?${ApiUrls.lat}=$latitude&${ApiUrls.lon}=$longitude&${ApiUrls.appId}=${ApiUrls.apiKey}&${ApiUrls.units}=${ApiUrls.metric}'));

    if (response.statusCode == 200) {
        weatherData = await json.decode(response.body);
          notifyListeners();
    } else {
      throw 'Failed to load weather data';
    }
    notifyListeners();
  }


  ///Initstate
  initStates(BuildContext context, {bool isSearch = false}) async {
    if(isSearch == true){
     var lat = await sharedPref.read('lti');
      var lng = await sharedPref.read('lng');
      await getWeatherData(double.parse(lat), double.parse(lng));
      notifyListeners();
    }else{
      permissionCheck();
      getUserLocation();
    }
  }

}
