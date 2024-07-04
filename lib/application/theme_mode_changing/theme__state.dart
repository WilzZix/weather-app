part of 'theme__bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

class AppThemeChanged extends ThemeState {
  final bool isDarkMode;

  AppThemeChanged(this.isDarkMode);
}
