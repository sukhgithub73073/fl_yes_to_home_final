import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yestohome/src/data/blocs/property_bloc/property_bloc.dart';
import 'package:yestohome/src/ui/add_property_screens/information_screen_pg_onwer.dart';
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

class InformationScreenPG extends StatefulWidget {
  const InformationScreenPG({super.key});

  @override
  State<InformationScreenPG> createState() => _InformationScreenPGState();
}

class _InformationScreenPGState extends State<InformationScreenPG> {
  //var PGFor = "";
  List<String> PGFor = [];
  List<String> suitedFor = [];

  var meals = "";

  var commonAreaList = [
    // ChipModel(title: "Living Room", isSelect: false),
    // ChipModel(title: "Kitchen", isSelect: false),
    // ChipModel(title: "Dining Haal", isSelect: false),
    // ChipModel(title: "Study Room", isSelect: false),
    // ChipModel(title: "Breakout Room", isSelect: false),
  ];

  final nameController = TextEditingController(text: "");
  final bedsController = TextEditingController(text: "");
  final priceController = TextEditingController(text: "");
  final noticeController = TextEditingController(text: "");
  final lockController = TextEditingController(text: "");
  final contactController = TextEditingController(text: "");
  final descriptionController = TextEditingController(text: "");

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
                text: "Step 3/5",
                color: colorMidGray,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 10.h),
            TextView(
                text: "PG Details",
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
                labelText: "PG Name",
                hintText: "",
                numberOfLines: 1,
                hintFontWeight: FontWeight.w400,
                hintTextColor: colorGray.withOpacity(0.6)),
            spaceVertical(space: 15.h),
            CustomTextField(
                controller: descriptionController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                hasViewHight: false,
                labelText: "Description",
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
            CustomTextField(
                controller: bedsController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                hasViewHight: false,
                labelText: "Total Beds",
                hintText: "",
                numberOfLines: 1,
                hintFontWeight: FontWeight.w400,
                hintTextColor: colorGray.withOpacity(0.6)),
            spaceVertical(space: 15.h),
            CustomTextField(
                controller: priceController,
                preffixicon: Icon(Icons.currency_rupee),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                hasViewHight: false,
                labelText: "Price per bed",
                hintText: "",
                numberOfLines: 1,
                hintFontWeight: FontWeight.w400,
                hintTextColor: colorGray.withOpacity(0.6)),
            spaceVertical(space: 15.h),

            TextView(
                text: "PG For",
                color: colorBlack,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 10.h),
            Row(
              children: [
                TapWidget(
                  onTap: () {
                    setState(() {
                      if (PGFor.contains("Boys")) {
                        PGFor.remove("Boys");
                      } else {
                        PGFor.add("Boys");
                      }
                    });
                  },
                  child: Container(
                    width: 125.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: PGFor.contains("Boys")
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: PGFor.contains("Boys")
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Boys",
                          color:
                              PGFor.contains("Boys") ? colorWhite : colorBlack,
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
                      if (PGFor.contains("Girls")) {
                        PGFor.remove("Girls");
                      } else {
                        PGFor.add("Girls");
                      }
                    });
                  },
                  child: Container(
                    width: 125.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: PGFor.contains("Girls")
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: PGFor.contains("Girls")
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Girls",
                          color:
                              PGFor.contains("Girls") ? colorWhite : colorBlack,
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
                text: "Best Suited for",
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
                      if (suitedFor.contains("Students")) {
                        suitedFor.remove("Students");
                      } else {
                        suitedFor.add("Students");
                      }
                    });
                  },
                  child: Container(
                    width: 125.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: suitedFor.contains("Students")
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: suitedFor.contains("Students")
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Students",
                          color: suitedFor.contains("Students")
                              ? colorWhite
                              : colorBlack,
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
                      if (suitedFor.contains("Professionals")) {
                        suitedFor.remove("Professionals");
                      } else {
                        suitedFor.add("Professionals");
                      }
                    });
                  },
                  child: Container(
                    width: 135.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: suitedFor.contains("Professionals")
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: suitedFor.contains("Professionals")
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Professionals",
                          color: suitedFor.contains("Professionals")
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
            spaceVertical(space: 15.h),
            TextView(
                text: "Meals Avialable",
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
                      meals = "Yes";
                    });
                  },
                  child: Container(
                    width: 125.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: meals == "Yes"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: meals == "Yes"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Yes",
                          color: meals == "Yes" ? colorWhite : colorBlack,
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
                      meals = "No";
                    });
                  },
                  child: Container(
                    width: 135.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: meals == "No"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: meals == "No"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "No",
                          color: meals == "No" ? colorWhite : colorBlack,
                          textSize: 13.sp,
                          textAlign: TextAlign.center,
                          style: AppTextStyleEnum.bold),
                    ),
                  ),
                ),
              ],
            ),
            spaceVertical(space: 15.h),
            CustomTextField(
                controller: noticeController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                hasViewHight: false,
                labelText: "Notice Period (Days)",
                hintText: "",
                numberOfLines: 1,
                hintFontWeight: FontWeight.w400,
                hintTextColor: colorGray.withOpacity(0.6)),
            spaceVertical(space: 15.h),
            CustomTextField(
                controller: lockController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                hasViewHight: false,
                labelText: "Lock In Period (Days)",
                hintText: "",
                numberOfLines: 1,
                hintFontWeight: FontWeight.w400,
                hintTextColor: colorGray.withOpacity(0.6)),
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
                child: Container(
                  height: 40.h,
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  child: AppSimpleButton(
                    onDoneFuction: () async {
                      if (nameController.text.isEmpty) {
                        showSnackBarError(context, "Invalid Title",
                            "Please enter valid PG name");
                      } else if (descriptionController.text.isEmpty) {
                        showSnackBarError(context, "Invalid Description",
                            "Please enter valid description");
                      } else if (contactController.text.length != 10) {
                        showSnackBarError(context, "Invalid Contact",
                            "Please enter valid contact number");
                      } else if (bedsController.text.isEmpty) {
                        showSnackBarError(context, "Invalid Beds",
                            "Please enter valid no of beds available");
                      } else if (priceController.text.isEmpty) {
                        showSnackBarError(context, "Invalid Price",
                            "Please enter valid price");
                      } else if (PGFor.isEmpty) {
                        showSnackBarError(context, "Invalid PG For",
                            "Please select value for PG for");
                      } else if (suitedFor.isEmpty) {
                        showSnackBarError(context, "Invalid Suitable For",
                            "Please select value for Suitable for");
                      } else if (meals.isEmpty) {
                        showSnackBarError(context, "Invalid Meals Available",
                            "Please select value for meals available");
                      } else if (noticeController.text.isEmpty) {
                        showSnackBarError(context, "Invalid Notice Period",
                            "Please enter valid notice period");
                      } else if (lockController.text.isEmpty) {
                        showSnackBarError(context, "Invalid Lock In Period",
                            "Please enter valid lock in period");
                      } else {
                        
                        AppData.propertyMap["title"] = nameController.text;
                        AppData.propertyMap["contact"] = contactController.text;
                        AppData.propertyMap["description"] =
                            descriptionController.text;
                        AppData.propertyMap["area"] = "";
                        AppData.propertyMap["price"] = priceController.text;
                        AppData.propertyMap["bedrooms"] = bedsController.text;
                        AppData.propertyMap["bathrooms"] = "";
                        AppData.propertyMap["parking"] = "";
                        AppData.propertyMap["furnishing"] = "";

                        AppData.propertyMap["pg_for"] = PGFor.join(', ');
                        AppData.propertyMap["suited_for"] = suitedFor.join(', ');
                        AppData.propertyMap["meal"] = meals;
                        AppData.propertyMap["notice_period"] = noticeController.text;
                        AppData.propertyMap["lock_in_period"] = lockController.text;


                        context.pushScreen(
                            nextScreen: OnwerInformationScreen());
                      }
                    },
                    buttonBackgroundColor: colorPrimary,
                    nameText: "Next",
                    textSize: 18.sp,
                  ),
                ));
          },
        ),
      ),
    );
  }
}
