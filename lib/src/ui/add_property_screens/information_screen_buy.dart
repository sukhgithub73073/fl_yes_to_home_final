import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yestohome/src/data/blocs/property_bloc/property_bloc.dart';
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


class InformationScreenBuy extends StatefulWidget {
  const InformationScreenBuy({super.key});

  @override
  State<InformationScreenBuy> createState() => _InformationScreenBuyState();
}

class _InformationScreenBuyState extends State<InformationScreenBuy> {

  var propertyType = "";

  final titleController = TextEditingController(text: "");
  final contactController = TextEditingController(text: "");
  final descriptionController = TextEditingController(text: "");
  final localityController = TextEditingController(text: "");
  final priceController = TextEditingController(text: "");
  final areaController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
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
                text: "Step 3/4",
                color: colorMidGray,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 10.h),
            TextView(
                text: "Store Listing",
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
            spaceVertical(space: 30.h),
            TextView(
                text: "Choose Type",
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
                      propertyType = "Residential";
                    });
                  },
                  child: Container(
                    width: 125.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: propertyType == "Residential"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: propertyType == "Residential"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Residential",
                          color: propertyType == "Residential" ? colorWhite : colorBlack,
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
                      propertyType = "Commercial";
                    });
                  },
                  child: Container(
                    width: 125.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: propertyType == "Commercial"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: propertyType == "Commercial"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Commercial",
                          color: propertyType == "Commercial"  ? colorWhite : colorBlack,
                          textSize: 13.sp,
                          textAlign: TextAlign.center,
                          style: AppTextStyleEnum.bold),
                    ),
                  ),
                ),
              ],
            ),
            spaceVertical(space: 20.h),

            CustomTextField(
                controller: titleController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                hasViewHight: false,
                labelText: "Title",
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
                controller: priceController,
                preffixicon: Icon(Icons.currency_rupee),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                hasViewHight: false,
                labelText: "Price",
                hintText: "",
                numberOfLines: 1,
                hintFontWeight: FontWeight.w400,
                hintTextColor: colorGray.withOpacity(0.6)),
            spaceVertical(space: 15.h),

            Container(
              child: CustomTextField(
                  controller: areaController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  hasViewHight: false,
                  labelText: "Area (Sq ft)",
                  hintText: "",
                  numberOfLines: 1,
                  hintFontWeight: FontWeight.w400,
                  hintTextColor: colorGray.withOpacity(0.6)),
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
                child:  AppSimpleButton(
                  onDoneFuction: () async {
                    if (propertyType.isEmpty) {
                      showSnackBarError(context, "Invalid Type",
                          "Please select value for type");
                    } else if (titleController.text.isEmpty) {
                      showSnackBarError(
                          context, "Invalid Title", "Please select a type");
                    } else if (descriptionController.text.isEmpty) {
                      showSnackBarError(context, "Invalid Description",
                          "Please enter valid description");
                    } else if (contactController.text.isEmpty) {
                      showSnackBarError(context, "Invalid Contact Number",
                          "Please enter valid contact number");
                    } else if (priceController.text.isEmpty) {
                      showSnackBarError(
                          context, "Invalid Price", "Please enter valid price");
                    }else if (areaController.text.isEmpty) {
                      showSnackBarError(
                          context, "Invalid Area", "Please enter valid area");
                    } else {
                      
                      AppData.propertyMap["title"] = titleController.text;
                      AppData.propertyMap["contact"] = contactController.text;
                      AppData.propertyMap["description"] =
                          descriptionController.text;
                      AppData.propertyMap["area"] = areaController.text;
                      AppData.propertyMap["price"] = priceController.text;
                      AppData.propertyMap["bedrooms"] = "";
                      AppData.propertyMap["bathrooms"] = "";
                      AppData.propertyMap["parking"] = "";
                      AppData.propertyMap["furnishing"] = "";

                      AppData.propertyMap["pg_for"] = "";
                      AppData.propertyMap["suited_for"] = "";
                      AppData.propertyMap["meal"] = "";
                      AppData.propertyMap["notice_period"] = "";
                      AppData.propertyMap["lock_in_period"] = "";
                      AppData.propertyMap["ownerDetail"] = {};
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
