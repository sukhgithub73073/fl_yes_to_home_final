import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yestohome/src/data/blocs/property_bloc/property_bloc.dart';
import 'package:yestohome/src/data/models/property_model.dart';
import 'package:yestohome/src/utility/app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yestohome/src/core/app_button.dart';
import 'package:yestohome/src/core/app_colors.dart';
import 'package:yestohome/src/core/app_input_field.dart';
import 'package:yestohome/src/core/app_tap_widget.dart';
import 'package:yestohome/src/core/common_space.dart';
import 'package:yestohome/src/core/text_view.dart';
import 'package:yestohome/src/data/blocs/auth_bloc/auth_bloc.dart';
import 'package:yestohome/src/data/blocs/property_bloc/property_bloc.dart';
import 'package:yestohome/src/extension/app_extension.dart';
import 'package:yestohome/src/ui/add_property_screens/images_screen.dart';
import 'package:yestohome/src/utility/app_data.dart';
import 'package:yestohome/src/utility/app_util.dart';

class OnwerInformationScreen extends StatefulWidget {
  const OnwerInformationScreen({super.key});

  @override
  State<OnwerInformationScreen> createState() => _OnwerInformationScreenState();
}

class _OnwerInformationScreenState extends State<OnwerInformationScreen> {
  var vegStats = "";
  var timeStats = "";
  var visitorStats = "";
  var guardianStats = "";
  var drinkingStats = "";

  final nameController = TextEditingController(text: "");
  final contactController = TextEditingController(text: "");

  var textTheme;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(
        backgroundColor: colorBg,
        leading: TapWidget(
          onTap: context.back,
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ListView(
          shrinkWrap: true,
          children: [
            TextView(
                text: "Step 4/5",
                color: colorMidGray,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 10.h),
            TextView(
                text: "Onwer Details",
                color: colorBlack,
                textSize: 16.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.bold),
            spaceVertical(space: 10.h),
            TextView(
                text:
                    "Selecting captivating images for your property would enhance its appeal. Aim for a minimum of 8 images",
                color: colorBlack,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 20.h),
            CustomTextField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                hasViewHight: false,
                labelText: "Name",
                hintText: "",
                numberOfLines: 1,
                hintFontWeight: FontWeight.w400,
                hintTextColor: colorGray.withOpacity(0.6)),
            spaceVertical(space: 15.h),
            CustomTextField(
                controller: contactController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                hasViewHight: false,
                labelText: "Contact Number",
                hintText: "",
                numberOfLines: 1,
                hintFontWeight: FontWeight.w400,
                hintTextColor: colorGray.withOpacity(0.6)),
            spaceVertical(space: 15.h),
            spaceVertical(space: 15.h),
            TextView(
                text: "Non-Veg Allowed",
                color: colorBlack,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 15.h),
            Row(
              children: [
                TapWidget(
                  onTap: () {
                    setState(() {
                      vegStats = "Yes";
                    });
                  },
                  child: Container(
                    width: 125.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: vegStats == "Yes"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: vegStats == "Yes"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Yes",
                          color: vegStats == "Yes"  ? colorWhite : colorBlack,
                          textSize: 13.sp,
                          textAlign: TextAlign.center,
                          style: AppTextStyleEnum.bold),
                    ),
                  ),
                ),
                spaceHorizontal(space: 10.w),
                TapWidget(
                  onTap: () {
                    setState(() {
                      vegStats = "No";
                    });
                  },
                  child: Container(
                    width: 135.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: vegStats == "No"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: vegStats == "No"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "No",
                          color: vegStats == "No"  ? colorWhite : colorBlack,
                          textSize: 13.sp,
                          textAlign: TextAlign.center,
                          style: AppTextStyleEnum.bold),
                    ),
                  ),
                ),
              ],
            ),
            spaceVertical(space: 15.h),
            TextView(
                text: "Any Time Allowed",
                color: colorBlack,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 15.h),
            Row(
              children: [
                TapWidget(
                  onTap: () {
                    setState(() {
                      timeStats = "Yes";
                    });
                  },
                  child: Container(
                    width: 125.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: timeStats == "Yes"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: timeStats == "Yes"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Yes",
                          color: timeStats == "Yes"  ? colorWhite : colorBlack,
                          textSize: 13.sp,
                          textAlign: TextAlign.center,
                          style: AppTextStyleEnum.bold),
                    ),
                  ),
                ),
                spaceHorizontal(space: 10.w),
                TapWidget(
                  onTap: () {
                    setState(() {
                      timeStats = "No";
                    });
                  },
                  child: Container(
                    width: 135.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: timeStats == "No"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: timeStats == "No"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "No",
                          color: timeStats == "No"  ? colorWhite : colorBlack,
                          textSize: 13.sp,
                          textAlign: TextAlign.center,
                          style: AppTextStyleEnum.bold),
                    ),
                  ),
                ),
              ],
            ),
            spaceVertical(space: 15.h),
            TextView(
                text: "Visitor Allowed",
                color: colorBlack,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 15.h),
            Row(
              children: [
                TapWidget(
                  onTap: () {
                    setState(() {
                      visitorStats = "Yes";
                    });
                  },
                  child: Container(
                    width: 125.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: visitorStats == "Yes"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: visitorStats == "Yes"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Yes",
                          color: visitorStats == "Yes"  ? colorWhite : colorBlack,
                          textSize: 13.sp,
                          textAlign: TextAlign.center,
                          style: AppTextStyleEnum.bold),
                    ),
                  ),
                ),
                spaceHorizontal(space: 10.w),
                TapWidget(
                  onTap: () {
                    setState(() {
                      visitorStats = "No";
                    });
                  },
                  child: Container(
                    width: 135.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: visitorStats == "No"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: visitorStats == "No"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "No",
                          color: visitorStats == "No"  ? colorWhite : colorBlack,
                          textSize: 13.sp,
                          textAlign: TextAlign.center,
                          style: AppTextStyleEnum.bold),
                    ),
                  ),
                ),
              ],
            ),
            spaceVertical(space: 15.h),
            TextView(
                text: "Guardian Allowed",
                color: colorBlack,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 15.h),
            Row(
              children: [
                TapWidget(
                  onTap: () {
                    setState(() {
                      guardianStats = "Yes";
                    });
                  },
                  child: Container(
                    width: 125.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: guardianStats == "Yes"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: guardianStats == "Yes"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Yes",
                          color: guardianStats == "Yes"  ? colorWhite : colorBlack,
                          textSize: 13.sp,
                          textAlign: TextAlign.center,
                          style: AppTextStyleEnum.bold),
                    ),
                  ),
                ),
                spaceHorizontal(space: 10.w),
                TapWidget(
                  onTap: () {
                    setState(() {
                      guardianStats = "No";
                    });
                  },
                  child: Container(
                    width: 135.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: guardianStats == "No"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: guardianStats == "No"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "No",
                          color: guardianStats == "No"  ? colorWhite : colorBlack,
                          textSize: 13.sp,
                          textAlign: TextAlign.center,
                          style: AppTextStyleEnum.bold),
                    ),
                  ),
                ),
              ],
            ),
            spaceVertical(space: 15.h),
            TextView(
                text: "Drinking/Smoking Allowed",
                color: colorBlack,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 15.h),
            Row(
              children: [
                TapWidget(
                  onTap: () {
                    setState(() {
                      drinkingStats = "Yes";
                    });
                  },
                  child: Container(
                    width: 125.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: drinkingStats == "Yes"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: drinkingStats == "Yes"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Yes",
                          color: drinkingStats == "Yes"  ? colorWhite : colorBlack,
                          textSize: 13.sp,
                          textAlign: TextAlign.center,
                          style: AppTextStyleEnum.bold),
                    ),
                  ),
                ),
                spaceHorizontal(space: 10.w),
                TapWidget(
                  onTap: () {
                    setState(() {
                      drinkingStats = "No";
                    });
                  },
                  child: Container(
                    width: 135.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: drinkingStats == "No"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: drinkingStats == "No"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "No",
                          color: drinkingStats == "No"  ? colorWhite : colorBlack,
                          textSize: 13.sp,
                          textAlign: TextAlign.center,
                          style: AppTextStyleEnum.bold),
                    ),
                  ),
                ),
              ],
            ),
            spaceVertical(space: 15.h),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10.r),
        child: BlocConsumer<PropertyBloc, PropertyState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 15),
              child:
              Container(
                  height: 40.h,
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  child: AppSimpleButton(
                  onDoneFuction: () async {
                    if (nameController.text.isEmpty) {
                      showSnackBarError(context, "Invalid Onwer Name",
                          "Please enter valid onwer name");
                    } else if (contactController.text.length != 10) {
                      showSnackBarError(context, "Invalid Onwer Contact",
                          "Please enter valid onwer contact number");
                    } else if (vegStats.isEmpty) {
                      showSnackBarError(context, "Invalid Vegetarian Status",
                          "Please select value for vegetarian status");
                    } else if (timeStats.isEmpty) {
                      showSnackBarError(context, "Invalid Time Status",
                          "Please select value for time status");
                    } else if (visitorStats.isEmpty) {
                      showSnackBarError(context, "Invalid Visitor Status",
                          "Please select value for visitor status");
                    } else if (guardianStats.isEmpty) {
                      showSnackBarError(context, "Invalid Guardian Status",
                          "Please select value for guardian status");
                    } else if (drinkingStats.isEmpty) {
                      showSnackBarError(context, "Invalid Drinking Status",
                          "Please select value for drinking status");
                    } else {
                      OnwerDetail ownerDetail = OnwerDetail(
                        name: nameController.text,
                        mobile: contactController.text,
                        veg_status: vegStats,
                        time_status: timeStats,
                        visitor_status: visitorStats,
                        guardian_status: guardianStats,
                        drinking_status: drinkingStats,
                      );
                      AppData.propertyMap["ownerDetail"] = ownerDetail.toJson();
                      context.pushScreen(nextScreen: ImagesScreen());
                    }
                  },
                  buttonBackgroundColor: colorPrimary,
                  nameText: "Next",
                  textSize: 18.sp,
                ),
              )

            );
          },
        ),
      ),
    );
  }
}
