part of 'change_local_bloc.dart';

@immutable
sealed class ChangeLocalEvent {}

class ChangeLocal extends ChangeLocalEvent {
  final String local;

  ChangeLocal(this.local);
}
