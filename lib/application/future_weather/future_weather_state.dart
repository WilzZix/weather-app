part of 'future_weather_bloc.dart';

@immutable
sealed class FutureWeatherState {}

final class FutureWeatherInitial extends FutureWeatherState {}

class FutureWeatherLoadingState extends FutureWeatherState {}

class FutureWeatherLoadedState extends FutureWeatherState {
  final FutureWeather data;

  FutureWeatherLoadedState(this.data);
}

class FutureWeatherLoadingErrorState extends FutureWeatherState {
  final String msg;

  FutureWeatherLoadingErrorState(this.msg);
}
