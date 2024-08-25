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
import 'package:yestohome/src/core/text_view.dart';
import 'package:yestohome/src/data/blocs/auth_bloc/auth_bloc.dart';
import 'package:yestohome/src/data/blocs/role_bloc/role_bloc.dart';
import 'package:yestohome/src/enums/role_enum.dart';
import 'package:yestohome/src/extension/app_extension.dart';
import 'package:yestohome/src/ui/auth_screens/otp_screen.dart';
import 'package:yestohome/src/ui/dashboard_screens/main_home_screen.dart';
import 'package:yestohome/src/utility/app_util.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController(text: "");
  final emailController = TextEditingController(text: "");
  final mobileController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  var _isPasswordVisible = false;
  Map<String, dynamic> map = {};

  @override
  void initState() {
    super.initState();
    context
        .read<RoleBloc>()
        .add(ChangeRoleEvent(roleEnum: RoleEnum.propertyUser));
  }

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
                height: size.height * 0.15,
                width: size.width * 0.15,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.31,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 15),
                    child: Text(
                      "Create your account to start finding your dream home!",
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  BlocConsumer<RoleBloc, RoleState>(
                    listener: (context, state) {
                      printLog(
                          "RoleBloc>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${state.toString()}");
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: Container(
                          width: size.width,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: colorPrimary.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TapWidget(
                                onTap: () {
                                  context.read<RoleBloc>().add(ChangeRoleEvent(
                                      roleEnum: RoleEnum.propertyUser));
                                },
                                child: Container(
                                    width: (size.width / 2) - 30,
                                    height: 40.h,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: state is RolePropertyUser
                                            ? colorPrimary
                                            : transparentColor,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                      child: TextView(
                                          text: "User",
                                          color: state is RolePropertyUser
                                              ? colorWhite
                                              : colorBlack,
                                          textSize: 13.sp,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyleEnum.bold),
                                    )),
                              ),
                              TapWidget(
                                onTap: () {
                                  context.read<RoleBloc>().add(ChangeRoleEvent(
                                      roleEnum: RoleEnum.propertyVendor));
                                },
                                child: Container(
                                  width: (size.width / 2) - 30,
                                  height: 40.h,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: state is RolePropertyVendor
                                          ? colorPrimary
                                          : transparentColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: TextView(
                                        text: "Vendor",
                                        color: state is RolePropertyVendor
                                            ? colorWhite
                                            : colorBlack,
                                        textSize: 13.sp,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyleEnum.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
                      child: Container(
                        alignment: Alignment.center,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: textTheme.titleSmall,
                          controller: nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.zero,
                            hintText: "Enter Name",
                            hintStyle: textTheme.bodyLarge?.copyWith(
                              color: colorLightGray,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
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
                      child: Container(
                        alignment: Alignment.center,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: textTheme.titleSmall,
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.zero,
                            hintText: "Enter Email",
                            hintStyle: textTheme.bodyLarge?.copyWith(
                              color: colorLightGray,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: colorMidGray, width: 1.0)),
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0)
                                        .copyWith(left: 10),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Image.asset(
                                      "assets/images/indian_flag_icon.png",
                                      height: 30,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 25,
                                      color: colorMidGray,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 4.0)
                                .copyWith(left: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: colorMidGray, width: 1.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "+91",
                                  style: textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      keyboardType: TextInputType.phone,
                                      onTap: () {
                                        _getPhoneNumber();
                                      },
                                      enabled: true,
                                      onChanged: null,
                                      style: textTheme.titleSmall,
                                      controller: mobileController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: "Enter Phone Number",
                                        hintStyle:
                                            textTheme.bodyLarge?.copyWith(
                                          color: colorLightGray,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Password",
                          suffixIcon: TapWidget(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible =
                                    !_isPasswordVisible; // Step 2
                              });
                            },
                            child: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: colorLightGray,
                            ),
                          ),
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
                        printLog(
                            "registerScreen>>>>>>>>>>AuthBloc${state.toString()}");
                        if (state is AuthError) {
                          showSnackBarError(context, "Error", "${state.error}");
                        } else if (state is AuthOtpSend) {
                          //OtpScreen
                          context.back();
                          context.pushReplacementScreen(
                              nextScreen: OtpScreen(
                            map: map,
                          ));
                        }
                        // else if (state is AuthSuccess) {
                        //   //OtpScreen
                        //   String jsonString =
                        //   json.encode(state.userModel.toJson());
                        //   getHiveStorage.write(
                        //       key: "LOGIN_RESPONSE", value: jsonString);
                        //   context.back();
                        //   context.pushReplacementScreen(
                        //       nextScreen: MainHomeScreen());
                        // }
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
                                  if (nameController.text.isEmpty) {
                                    showSnackBarError(context, "Invalid Name",
                                        "Please enter valid name");
                                  } else if (emailController.text.isEmpty) {
                                    showSnackBarError(context, "Invalid Email",
                                        "Please enter valid email");
                                  } else if (mobileController.text.length !=
                                      10) {
                                    showSnackBarError(
                                        context,
                                        "Invalid mobile number",
                                        "Please enter valid mobile number");
                                  } else if (passwordController.text.length <
                                      8) {
                                    showSnackBarError(
                                        context,
                                        "Invalid password",
                                        "Please enter valid password");
                                  } else {
                                    var RoleBlocState =
                                        context.read<RoleBloc>().state;
                                    var userType = RoleEnum.propertyUser.name;
                                    if (RoleBlocState is RolePropertyVendor) {
                                      userType = RoleEnum.propertyVendor.name;
                                    }
                                    map = {
                                      "name": nameController.text,
                                      "email": emailController.text,
                                      "phone": mobileController.text,
                                      "password": passwordController.text,
                                      "address": "",
                                      "profileImage": "",
                                      "userType": userType,
                                    };

                                    print(">>>>>>>>>>>>>>>>>>>>>>>>.${map}");
                                    context
                                        .read<AuthBloc>()
                                        .add(CheckRegisterAuthEvent(map: map));
                                  }
                                },
                                buttonBackgroundColor: colorPrimary,
                                nameText: "login",
                                textSize: 18.sp,
                              );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                            text: "If you have an account? ",
                          ),
                          TextSpan(
                            text: "Login here",
                            style: TextStyle(
                              color: colorPrimary,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.back();
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getPhoneNumber() async {
    String? phoneNumber = await SmsAutoFill().hint;
    print(">>>>>>>>>>>>>>>>>>>>>>>>$phoneNumber");
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      String phoneNumberWithoutCountryCode = phoneNumber.startsWith('+')
          ? phoneNumber.substring(phoneNumber.indexOf(' ') + 1)
          : phoneNumber;
      mobileController.text =
          phoneNumberWithoutCountryCode.replaceAll("+91", "");
      setState(() {});
    }
  }
}
