import 'package:http/http.dart' as http;
import 'package:weatherapp/model.dart';

class Api {
  Future<GetWeather> getweatherfromAPI() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=Mumbai&units=imperial&appid=b023eeabaa92965afc2273173c8e0655");
    final getWeather = getWeatherFromJson(response.body.toString());
    print(getWeather.clouds.all);
    return getWeather;
  }
}
