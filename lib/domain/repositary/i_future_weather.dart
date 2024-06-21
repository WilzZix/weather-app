import 'package:weather_app/infrostructure/dto/models/future_weather_model.dart';

abstract class IFutureWeatherRepository {
  Future<FutureWeather> getFutureWeather();
}
