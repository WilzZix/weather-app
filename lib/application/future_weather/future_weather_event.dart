part of 'future_weather_bloc.dart';

@immutable
sealed class FutureWeatherEvent {}

class GetFutureWeatherEvent extends FutureWeatherEvent {}
