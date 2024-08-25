import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_storage/hive_storage.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:upgrader/upgrader.dart';
import 'package:yestohome/src/core/app_button.dart';
import 'package:yestohome/src/core/app_colors.dart';
import 'package:yestohome/src/core/app_tap_widget.dart';
import 'package:yestohome/src/data/blocs/auth_bloc/auth_bloc.dart';
import 'package:yestohome/src/data/blocs/role_bloc/role_bloc.dart';
import 'package:yestohome/src/enums/role_enum.dart';
import 'package:yestohome/src/extension/app_extension.dart';
import 'package:yestohome/src/ui/dashboard_screens/main_home_screen.dart';
import 'package:yestohome/src/ui/auth_screens/register_screen.dart';
import 'package:yestohome/src/utility/app_util.dart';

class OtpScreen extends StatefulWidget {
  final Map<String, dynamic> map;

  const OtpScreen({super.key, required this.map});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return UpgradeAlert(
      showReleaseNotes: false,
      cupertinoButtonTextStyle: TextStyle(color: colorPrimary),
      showLater: false,
      showIgnore: false,
      dialogStyle: UpgradeDialogStyle.cupertino,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gradientOne, gradientTwo],
                    // Replace with your desired colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.1,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/images/logo.png",
                height: size.height * 0.2,
                width: size.width * 0.2,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.4,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 35, vertical: 1),
                    child: Text(
                      "Enter the 6-digits OTP we sent by SMS to +91 ${widget.map["phone"]}",
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 4.0)
                          .copyWith(left: 10),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: colorMidGray, width: 1.0)),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        style: textTheme.titleSmall,
                        controller: otpController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter OTP Here",
                          hintStyle: textTheme.bodyLarge?.copyWith(
                            color: colorLightGray,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) async {
                        printLog("OtpScreen>>>>>>>>>>AuthBloc");
                        if (state is AuthError) {
                          showSnackBarError(context, "Error", "${state.error}");
                        } else if (state is AuthSuccess) {
                          String jsonString =
                              json.encode(state.userModel.toJson());
                          getHiveStorage.write(
                              key: "LOGIN_RESPONSE", value: jsonString);

                          context.read<RoleBloc>().add(ChangeRoleEvent(
                              roleEnum: state.userModel.userType ==
                                      RoleEnum.propertyUser.name
                                  ? RoleEnum.propertyUser
                                  : RoleEnum.propertyVendor));

                          context.pushReplacementScreen(
                              nextScreen: MainHomeScreen());
                        }
                      },
                      builder: (context, state) {
                        return state is AuthLoading
                            ? Container(
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : AppSimpleButton(
                                onDoneFuction: () async {
                                  if (otpController.text.length != 10) {
                                    showSnackBarError(context, "Invalid OTP",
                                        "Please enter 6 digit valid OTP");
                                  } else {
                                    context
                                        .read<AuthBloc>()
                                        .add(LoginAuthEvent(map: {}));
                                  }
                                },
                                buttonBackgroundColor: colorPrimary,
                                nameText: "login",
                                textSize: 18.sp,
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorGray,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: "If you have not an account? ",
                          ),
                          TextSpan(
                            text: "Create account here",
                            style: TextStyle(
                              color: colorPrimary,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pushScreen(
                                    nextScreen: RegisterScreen());
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
