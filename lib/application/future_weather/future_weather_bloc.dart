import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/infrostructure/dto/models/future_weather_model.dart';

part 'future_weather_event.dart';

part 'future_weather_state.dart';

class FutureWeatherBloc extends Bloc<FutureWeatherEvent, FutureWeatherState> {
  FutureWeatherBloc() : super(FutureWeatherInitial()) {
    on<GetFutureWeatherEvent>(_getFutureWeather);
  }

  Future _getFutureWeather(
      GetFutureWeatherEvent event, Emitter<FutureWeatherState> emit) async {
    emit(FutureWeatherLoadingState());

  }
}
