part of 'change_local_bloc.dart';

@immutable
sealed class ChangeLocalState {}

final class ChangeLocalInitial extends ChangeLocalState {}

class LocalChanged extends ChangeLocalState {
  final String local;

  LocalChanged(this.local);
}
