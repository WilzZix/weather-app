import 'package:either_dart/either.dart';
import 'package:weather_app/domain/repositary/i_future_weather.dart';
import 'package:weather_app/infrostructure/dto/excetion/exception.dart';
import 'package:weather_app/infrostructure/dto/models/future_weather_model.dart';
import 'package:weather_app/infrostructure/services/network_provider.dart';

class FeatureWeatherRepository extends IFutureWeatherRepository {
  @override
  Future<Either<Failure, FutureWeather>> getFutureWeather() async {
    try {
      final response =
          await NetworkProvider.dio.get(NetworkProvider.routes.forecastWeather);
      return Right(FutureWeather.fromJson(response.data));
    } catch (e) {
      return Left(ErrorHandler.handle(e.toString()).failure);
    }
  }
}
