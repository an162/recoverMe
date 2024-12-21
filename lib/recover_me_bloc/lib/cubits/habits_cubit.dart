import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recover_me_bloc/data/repositories/habit_repository.dart';

part 'package:recover_me_bloc/cubits/habit_state.dart';

class HabitsCubit extends Cubit<HabitsState> {
  final HabitRepository _habitRepository;

  HabitsCubit(this._habitRepository) : super(HabitsInitial());

  /// Add a new habit
  Future<void> addHabit(String name, int target) async {
    emit(HabitsLoading());
    try {
      await _habitRepository.addHabit(name, target);
      emit(HabitsSuccess('Habit added successfully!'));
    } catch (e) {
      emit(HabitsError('Failed to add habit: $e'));
    }
  }

  Future<void> fetchHabits() async {
    emit(HabitsLoading());
    try {
      final habits = await _habitRepository.getHabits();
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitsError('Failed to fetch habits: $e'));
    }
  }


Future<void> deleteHabit(int id) async {
  emit(HabitsLoading());
  try {
    await _habitRepository.deleteHabit(id); 
    
    final updatedHabits = await _habitRepository.getHabits();
    emit(HabitsLoaded(updatedHabits));
  } catch (e) {
    emit(HabitsError('Failed to delete habit: $e'));
  }
}


Future<void> updateHabit(int id, int currentValue) async {
  emit(HabitsLoading());
  try {
    await _habitRepository.updateHabit(id, currentValue);
    final updatedHabits = await _habitRepository.getHabits();
    emit(HabitsLoaded(updatedHabits));
  } catch (e) {
    emit(HabitsError('Failed to update habit: $e'));
  }
}

}
