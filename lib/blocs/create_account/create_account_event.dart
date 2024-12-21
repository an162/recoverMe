import 'package:equatable/equatable.dart';

abstract class CreateAccountEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateAccountSubmitted extends CreateAccountEvent {
  final String name;
  final String surname;
  final String email;
  final String password;
  final String birthdate;
  final String gender;

  CreateAccountSubmitted({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.birthdate,
    required this.gender,
  });

  @override
  List<Object?> get props => [name, surname, email, password, birthdate, gender];
}
