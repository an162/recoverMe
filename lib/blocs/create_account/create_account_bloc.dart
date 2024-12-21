import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../database/database_helper.dart';
import 'create_account_event.dart';
import 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  final DBHelper dbHelper;

  CreateAccountBloc({required this.dbHelper}) : super(CreateAccountInitial());

  @override
  Stream<CreateAccountState> mapEventToState(CreateAccountEvent event) async* {
    if (event is CreateAccountSubmitted) {
      yield CreateAccountLoading();
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
        yield CreateAccountSuccess();
      } catch (e) {
        yield CreateAccountFailure("Error saving user: ${e.toString()}");
      }
    }
  }
}
