import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/infrostructure/dto/models/future_weather_model.dart';
import 'package:weather_app/infrostructure/dto/repository/future_weather_repository.dart';

part 'future_weather_event.dart';

part 'future_weather_state.dart';

class FutureWeatherBloc extends Bloc<FutureWeatherEvent, FutureWeatherState> {
  FutureWeatherBloc() : super(FutureWeatherInitial()) {
    on<GetFutureWeatherEvent>(_getFutureWeather);
  }

  FeatureWeatherRepository repository = FeatureWeatherRepository();

  Future _getFutureWeather(
      GetFutureWeatherEvent event, Emitter<FutureWeatherState> emit) async {
    emit(FutureWeatherLoadingState());
    final data = await repository.getFutureWeather();
    data.fold((l) {
      log('line 24 ${l.message}');
      emit(FutureWeatherLoadingErrorState(l.message));
    }, (r) {
      emit(FutureWeatherLoadedState(r));
    });
  }
}
