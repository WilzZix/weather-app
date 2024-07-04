import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme__event.dart';

part 'theme__state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ChangeAppTheme>((event, emit) {
      emit(AppThemeChanged(event.isDarkMode));
    });
  }
}
