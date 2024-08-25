part of 'role_bloc.dart';

sealed class RoleEvent extends Equatable {
  const RoleEvent();
}

class ChangeRoleEvent extends RoleEvent {
  final RoleEnum roleEnum;

  const ChangeRoleEvent({required this.roleEnum});

  @override
  List<Object?> get props => [roleEnum];
}
