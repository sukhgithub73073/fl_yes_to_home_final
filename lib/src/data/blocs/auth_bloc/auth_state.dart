part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}
final class AuthOtpSend extends AuthState {
  @override
  List<Object> get props => [];
}
//test

final class AuthSuccess extends AuthState {
  final UserModel userModel;

  AuthSuccess({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

final class AuthError extends AuthState {
  final String error;

  AuthError({required this.error});

  @override
  List<Object> get props => [error];
}
