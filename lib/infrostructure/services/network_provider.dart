import 'package:dio/dio.dart';

class NetworkProvider {
  //api kay : ed8149a25aeb46f6a98104107241806
  static Dio dio = Dio(BaseOptions(baseUrl: 'https://api.weatherapi.com/v1/'));
}
