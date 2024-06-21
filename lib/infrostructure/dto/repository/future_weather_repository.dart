import 'package:weather_app/domain/repositary/i_future_weather.dart';
import 'package:weather_app/infrostructure/dto/models/future_weather_model.dart';
import 'package:weather_app/infrostructure/services/network_provider.dart';

class FeatureWeatherRepository extends IFutureWeatherRepository {
  @override
  Future<FutureWeather> getFutureWeather() async {
    final response =
        await NetworkProvider.dio.get('https://api.weatherapi.com/v1/');
    return FutureWeather.fromJson(response.data);
  }
}
