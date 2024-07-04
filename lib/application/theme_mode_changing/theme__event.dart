part of 'theme__bloc.dart';

@immutable
sealed class ThemeEvent {}

class ChangeAppTheme extends ThemeEvent {
  final bool isDarkMode;

  ChangeAppTheme(this.isDarkMode);
}
