import 'package:easy_localization/easy_localization.dart';
import 'package:yestohome/src/core/app_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yestohome/src/ui/app/app.dart';
import 'package:hive_storage/hive_storage.dart';
import 'package:upgrader/upgrader.dart';
import 'package:yestohome/src/utility/app_data.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Upgrader.clearSavedSettings();
  await EasyLocalization.ensureInitialized();
  await HiveStorageImp.hiveInjector();
  await ScreenUtil.ensureScreenSize();
  AppData.db = await mongo.Db.create(
      "mongodb+srv://yestohome:HpvZyjAP3G85dQ3i@atlascluster.ghqkn.mongodb.net/?retryWrites=true&w=majority&appName=AtlasCluster");
  await AppData.db.open();


  await AppInjector.init(appRunner: () => runApp(EasyLocalization(
      supportedLocales: [Locale('en'),Locale('hi'),Locale("pa")],
      path: 'assets/translations',
      startLocale: Locale('en'),
      fallbackLocale: Locale('en'),
      child: SafeArea(bottom: false,top: false, child: MyApp()))));
}
