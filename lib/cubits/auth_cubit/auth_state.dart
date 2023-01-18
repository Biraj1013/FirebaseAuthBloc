import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthCodeSentsState extends AuthState {}

class AuthCodeVerifiedState extends AuthState {}

class AuthCodeLoggedInState extends AuthState {
  final User firebeseUser;

  AuthCodeLoggedInState(this.firebeseUser);
}

class AuthCodeLoggedOutState extends AuthState {}

class AuthCodeErrorState extends AuthState {
  final String error;

  AuthCodeErrorState(this.error);
}
