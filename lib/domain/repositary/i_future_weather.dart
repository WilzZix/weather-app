import 'package:either_dart/either.dart';
import 'package:weather_app/infrostructure/dto/excetion/exception.dart';
import 'package:weather_app/infrostructure/dto/models/future_weather_model.dart';

abstract class IFutureWeatherRepository {
  Future<Either<Failure,FutureWeather>> getFutureWeather();
}
