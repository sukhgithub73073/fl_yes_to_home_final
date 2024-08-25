part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginAuthEvent extends AuthEvent {
  final Map<String, dynamic> map;

  const LoginAuthEvent({required this.map});

  @override
  List<Object?> get props => [map];
}

class CheckRegisterAuthEvent extends AuthEvent {
  final Map<String, dynamic> map;

  const CheckRegisterAuthEvent({required this.map});

  @override
  List<Object?> get props => [map];
}

class RegisterAuthEvent extends AuthEvent {
  final Map<String, dynamic> map;

  const RegisterAuthEvent({required this.map});

  @override
  List<Object?> get props => [map];
}

class GetProfileAuthEvent extends AuthEvent {
  const GetProfileAuthEvent();

  @override
  List<Object?> get props => [];
}
