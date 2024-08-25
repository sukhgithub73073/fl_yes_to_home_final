import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yestohome/src/enums/role_enum.dart';

part 'role_event.dart';

part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(RoleInitial()) {
    on<ChangeRoleEvent>(_changeRole);
  }

  FutureOr<void> _changeRole(ChangeRoleEvent event, Emitter<RoleState> emit) {
    emit(RoleLoading());
    if (event.roleEnum == RoleEnum.propertyVendor) {
      emit(RolePropertyVendor());
    } else if (event.roleEnum == RoleEnum.propertyUser) {
      emit(RolePropertyUser());
    }
  }
}
