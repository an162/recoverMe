import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../database/database_helper.dart';

// Events
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends LoginEvent {}

// States
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DatabaseHelper dbHelper;

  LoginBloc({required this.dbHelper}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitted) {
      yield LoginLoading();
      try {
        final users = await dbHelper.getUser(event.email);
        if (users.isNotEmpty) {
          final user = users.first;
          if (user['password'] == event.password) {
            yield LoginSuccess();
          } else {
            yield LoginFailure("Invalid password. Please try again.");
          }
        } else {
          yield LoginFailure("User not found. Please sign up.");
        }
      } catch (e) {
        yield LoginFailure("An error occurred. Please try again later.");
      }
    } else if (event is LogoutEvent) {
      yield LoginInitial();
    }
  }
}