import 'dart:convert';

import 'package:yestohome/src/core/app_assets.dart';
import 'package:yestohome/src/core/app_colors.dart';
import 'package:yestohome/src/core/app_image_view.dart';
import 'package:yestohome/src/data/blocs/auth_bloc/auth_bloc.dart';
import 'package:yestohome/src/data/blocs/language_bloc/language_bloc.dart';
import 'package:yestohome/src/data/blocs/role_bloc/role_bloc.dart';
import 'package:yestohome/src/data/models/user_model.dart';
import 'package:yestohome/src/enums/role_enum.dart';
import 'package:yestohome/src/extension/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_storage/hive_storage.dart';
import 'package:yestohome/src/ui/auth_screens/login_screen.dart';
import 'package:yestohome/src/ui/dashboard_screens/main_home_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3)).then((value) async {
        var loginResponse = await getHiveStorage.read<String>(
            key: "LOGIN_RESPONSE", defaultValue: "");
        if (loginResponse == "") {
          context.pushReplacementScreen(nextScreen: LoginScreen());
        } else {
          context.read<AuthBloc>().add(GetProfileAuthEvent());
          Map<String, dynamic> jsonMap = json.decode(loginResponse ?? "");
          UserModel userModel = UserModel.fromJson(jsonMap);

          context.read<RoleBloc>().add(ChangeRoleEvent(
              roleEnum: userModel.userType == RoleEnum.propertyUser.name
                  ? RoleEnum.propertyUser
                  : RoleEnum.propertyVendor));
          context.pushReplacementScreen(nextScreen: MainHomeScreen());
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
              colorSecendry,
              Colors.white,
            ], center: Alignment.topLeft, radius: 0.5.r)),
          ),
          Center(
              child: ImageView(
            height: 150.h,
            width: 150.w,
            url: AppAssets.logo,
            imageType: ImageType.asset,
          )),
        ],
      ),
    );
  }
}
