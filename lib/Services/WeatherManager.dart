import 'package:EigitalFacebook/Model/Weather.dart';
import 'package:location/location.dart';
import 'package:http/http.dart';
import 'package:EigitalFacebook/Constants/Constants.dart';

class WeatherManager {
  String apiKey = Constants().weatherApi;
  getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  Future<Weather> getWeather() async {
    LocationData location = await getLocation();
    String longtitude = location.longitude.toString();
    String latitude = location.latitude.toString();

    Response response = await get(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longtitude&appid=$apiKey&units=metric');
    if (response.statusCode == 200) {
      String data = response.body;
      return weatherFromJson(data);
      //return data;
    } else {
      print(response.statusCode);
    }
  }

  Future<Weather> searchWeather(String cityName) async {
    Response response = await get(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return weatherFromJson(data);
      //return data;
    } else {
      print(response.statusCode);
    }
  }
}
