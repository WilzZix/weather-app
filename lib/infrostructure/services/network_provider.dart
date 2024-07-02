import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/utils/api_routes/api_routes.dart';

class NetworkProvider {
  static ApiRoutes routes = const ApiRoutes();

  //api kay : fa499bdc63cc4e5187693956242606
  //api key for amadeus.com : YU25yNq3RXRFGTc25vs5TT5N5NmxkqwE
  static Dio dio = Dio(BaseOptions(
      baseUrl: routes.baseUrl,
      headers: {"key": "fa499bdc63cc4e5187693956242606"}))
    ..interceptors.addAll([
      LogInterceptor(
        responseHeader: true,
        responseBody: true,
        requestBody: true,
        logPrint: (error) => log(
          error.toString(),
        ),
      )
    ]);
}
