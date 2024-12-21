import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recover_me_bloc/data/repositories/sober_repository..dart';

// SoberCubit States
abstract class SoberState extends Equatable {
  @override
  List<Object> get props => [];
}

class SoberInitial extends SoberState {}

class SoberLoaded extends SoberState {
  final int soberDays;

  SoberLoaded(this.soberDays);

  @override
  List<Object> get props => [soberDays];
}

class SoberError extends SoberState {
  final String message;

  SoberError(this.message);

  @override
  List<Object> get props => [message];
}

// SoberCubit to handle sober days
class SoberCubit extends Cubit<SoberState> {
  final SoberRepository _soberRepository;

  SoberCubit(this._soberRepository) : super(SoberInitial());

  // Fetch the sober days from the repository
  Future<void> fetchSoberDays() async {
    try {
      final soberDays = await _soberRepository.getSoberDays();
      emit(SoberLoaded(soberDays));
    } catch (e) {
      emit(SoberError("Failed to load sober days"));
    }
  }

  // Update the sober days in the repository
  Future<void> updateSoberDays(int newSoberDays) async {
    try {
      await _soberRepository.updateSoberDays(newSoberDays);
      emit(SoberLoaded(newSoberDays));
    } catch (e) {
      emit(SoberError("Failed to update sober days"));
    }
  }

  // Reset the sober days to 0
  Future<void> resetSoberDays() async {
    await updateSoberDays(0); // Reset by updating to 0
  }
}
