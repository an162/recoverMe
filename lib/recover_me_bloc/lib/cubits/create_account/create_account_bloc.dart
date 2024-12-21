import 'package:flutter_bloc/flutter_bloc.dart';
import '../../database/database_helper.dart';
import 'create_account_event.dart';
import 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  final DatabaseHelper dbHelper;

  CreateAccountBloc({required this.dbHelper}) : super(CreateAccountInitial()) {
    on<CreateAccountSubmitted>(_onCreateAccountSubmitted);
  }

  Future<void> _onCreateAccountSubmitted(
      CreateAccountSubmitted event, Emitter<CreateAccountState> emit) async {
    emit(CreateAccountLoading());
    try {
      final user = {
        'name': event.name,
        'surname': event.surname,
        'email': event.email,
        'password': event.password,
        'birthdate': event.birthdate,
        'gender': event.gender,
        'addiction': null,
      };

      await dbHelper.insertUser(user);
      emit(CreateAccountSuccess());
    } catch (e) {
      emit(CreateAccountFailure("Error saving user: ${e.toString()}"));
    }
  }
}
