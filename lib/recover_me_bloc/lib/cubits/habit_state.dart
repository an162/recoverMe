part of 'habits_cubit.dart';

abstract class HabitsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HabitsInitial extends HabitsState {}

class HabitsLoading extends HabitsState {}

class HabitsSuccess extends HabitsState {
  final String message;
  HabitsSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class HabitsLoaded extends HabitsState {
  final List<Map<String, dynamic>> habits;

  HabitsLoaded(this.habits);

  @override
  List<Object?> get props => [habits];
}

class HabitsError extends HabitsState {
  final String message;

  HabitsError(this.message);

  @override
  List<Object?> get props => [message];
}
