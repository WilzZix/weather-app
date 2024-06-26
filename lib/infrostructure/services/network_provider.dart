import 'dart:developer';

import 'package:dio/dio.dart';

class NetworkProvider {
  //api kay : fa499bdc63cc4e5187693956242606
  static Dio dio = Dio(BaseOptions(
      baseUrl: 'https://api.weatherapi.com/v1/forecast.json?q=10001&days=14',
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
