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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController(text: "7307372923");
  final passwordController = TextEditingController(text: "Qwerty@123");
  var _isPasswordVisible = false;

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
                    colors: [gradientOne, gradientTwo], // Replace with your desired colors
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
              margin: EdgeInsets.only(top: size.height * 0.4,),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(40),
                  topRight: Radius.circular(40)
              )),
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [

                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 1),
                    child: Text(
                      "Your next home is just a login away. Let's find it together!",
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
                    padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                                padding: const EdgeInsets.symmetric(vertical: 4.0)
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
                                border:
                                Border.all(color: colorMidGray, width: 1.0)),
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
                                      controller: phoneController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: "Enter Phone Number",
                                        hintStyle: textTheme.bodyLarge?.copyWith(
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
                    padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                        printLog("loginScreen>>>>>>>>>>AuthBloc");
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
                            if (phoneController.text.length != 10) {
                              showSnackBarError(context, "Invalid Mobile",
                                  "Please enter 10 digit valid mobile number");
                            } else if (passwordController.text.length < 8) {
                              showSnackBarError(context, "Invalid password",
                                  "Please enter 8 digit valid password");
                            } else {
                              context
                                  .read<AuthBloc>()
                                  .add(LoginAuthEvent(map: {
                                "phone": phoneController.text,
                                "password": passwordController.text,
                              }));
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: colorLightGray,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "or",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: colorGray),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: colorLightGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          // mongoDBInit() ;
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(colorLightGray),
                          shape: MaterialStateProperty.all(
                            const CircleBorder(),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset(
                            "assets/images/google_icon.png",
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(colorLightGray),
                          shape: MaterialStateProperty.all(
                            const CircleBorder(),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset(
                            "assets/images/facebook_icon.png",
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                    ],
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
                                context.pushScreen(nextScreen: RegisterScreen());
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

  Future<void> _getPhoneNumber() async {
    String? phoneNumber = await SmsAutoFill().hint;

    print(">>>>>>>>>>>>>>>>>>>>>>>>$phoneNumber");
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      String phoneNumberWithoutCountryCode = phoneNumber.startsWith('+')
          ? phoneNumber.substring(phoneNumber.indexOf(' ') + 1)
          : phoneNumber;
      phoneController.text =
          phoneNumberWithoutCountryCode.replaceAll("+91", "");

      setState(() {});
    }
  }
}
