part of 'role_bloc.dart';

sealed class RoleState extends Equatable {
  const RoleState();
}

final class RoleInitial extends RoleState {
  @override
  List<Object> get props => [];
}

final class RoleLoading extends RoleState {
  @override
  List<Object> get props => [];
}

final class RolePropertyVendor extends RoleState {
  @override
  List<Object> get props => [];
}
final class RolePropertyUser extends RoleState {
  @override
  List<Object> get props => [];
}