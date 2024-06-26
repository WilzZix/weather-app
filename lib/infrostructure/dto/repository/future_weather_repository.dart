import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:weather_app/domain/repositary/i_future_weather.dart';
import 'package:weather_app/infrostructure/dto/excetion/exception.dart';
import 'package:weather_app/infrostructure/dto/models/future_weather_model.dart';
import 'package:weather_app/infrostructure/services/network_provider.dart';

class FeatureWeatherRepository extends IFutureWeatherRepository {
  @override
  Future<Either<Failure, FutureWeather>> getFutureWeather() async {
    try {
      final response = await NetworkProvider.dio
          .get('https://api.weatherapi.com/v1/forecast.json?q=10001&days=1');
      return Right(FutureWeather.fromJson(response.data));
    } catch (e) {
      log('line 17 ${e.toString()}');
      return Left(ErrorHandler.handle(e.toString()).failure);
    }
  }
}
