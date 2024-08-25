import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:yestohome/src/data/repository/auth_repo.dart';
import 'package:yestohome/src/data/repository/property_repo.dart';
typedef AppRunner = FutureOr<void> Function();

class AppInjector {
  static Future<void> init({
    required AppRunner appRunner,
  }) async {
    await _initDependencies();
    appRunner();
  }

  static Future<void> _initDependencies() async {
    await GetIt.I.allReady();

    GetIt.I.registerSingleton<AuthRepository>(AuthRepositoryImp());
    GetIt.I.registerSingleton<PropertyRepository>(PropertyRepositoryImp());
    GetIt.I.registerSingleton<GlobalKey<NavigatorState>>(GlobalKey<NavigatorState>());

  }
}