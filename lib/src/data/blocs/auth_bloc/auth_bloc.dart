import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_storage/hive_storage.dart';
import 'package:yestohome/src/data/models/response_model.dart';
import 'package:yestohome/src/data/models/user_model.dart';
import 'package:yestohome/src/data/repository/auth_repo.dart';
import 'package:yestohome/src/utility/app_util.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  var authRepository = GetIt.I<AuthRepository>();

  AuthBloc() : super(AuthInitial()) {
    on<LoginAuthEvent>(_login);
    on<CheckRegisterAuthEvent>(_requestOtp);
    on<RegisterAuthEvent>(_register);
    on<GetProfileAuthEvent>(_getProfile);
  }

  Future<void> _login(LoginAuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      ResponseModel responseModel = await authRepository.loginApi(event.map);
      if (responseModel.status) {
        emit(AuthSuccess(userModel: UserModel.fromJson(responseModel.data)));
      } else {
        emit(AuthError(error: responseModel.message));
      }
    } catch (e, t) {
      printLog("_login>>>Exception: $e $t");
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _register(
      RegisterAuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      ResponseModel responseModel = await authRepository.registerApi(event.map);
      if (responseModel.status) {
        emit(AuthSuccess(userModel: UserModel.fromJson(responseModel.data)));
      } else {
        emit(AuthError(error: responseModel.message));
      }
    } catch (e, t) {
      printLog("_login>>>Exception: $e $t");
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _getProfile(
      GetProfileAuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      var loginResponse = await getHiveStorage.read<String>(
          key: "LOGIN_RESPONSE", defaultValue: "");
      Map<String, dynamic> jsonMap = json.decode(loginResponse ?? "");
      UserModel userModel = UserModel.fromJson(jsonMap);
      userModel.id = mongo.ObjectId.parse(userModel.id);
      emit(AuthSuccess(userModel: userModel));
    } catch (e, t) {
      printLog("_login>>>Exception: $e $t");
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _requestOtp(CheckRegisterAuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      ResponseModel responseModel = await authRepository.requestOtpApi(event.map);
      if (responseModel.status) {
        emit(AuthOtpSend());
      } else {
        emit(AuthError(error: responseModel.message));
      }
    } catch (e, t) {
      printLog("_requestOtp>>>Exception: $e $t");
      emit(AuthError(error: e.toString()));
    }
  }
}
