import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_local_event.dart';

part 'change_local_state.dart';

class ChangeLocalBloc extends Bloc<ChangeLocalEvent, ChangeLocalState> {
  ChangeLocalBloc() : super(ChangeLocalInitial()) {
    on<ChangeLocal>((event, emit) {
      emit(LocalChanged(event.local));
    });
  }
}
