import 'package:flutter/cupertino.dart';
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

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {

  var furnishingValue = "Without Furnished";
  final titleController = TextEditingController(text: "");
  final contactController = TextEditingController(text: "");
  final descriptionController = TextEditingController(text: "");
  final priceController = TextEditingController(text: "");
  final bedroomsController = TextEditingController(text: "");
  final bathroomsController = TextEditingController(text: "");
  final areaController = TextEditingController(text: "");
  final parkingController = TextEditingController(text: "");

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
            spaceVertical(space: 15.h),
            // AppChipsWidget(
            //     onChange: (index) {
            //      //  titleController.text = titleList[index];
            //     },
            //     list: titleList),
            //
            //
            // spaceVertical(space: 20.h),
            CustomTextField(
                controller: contactController,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                preffixicon: Icon(Icons.call),
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
            CustomTextField(
                controller: bedroomsController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                hasViewHight: false,
                labelText: "No of bedrooms",
                hintText: "",
                numberOfLines: 1,
                hintFontWeight: FontWeight.w400,
                hintTextColor: colorGray.withOpacity(0.6)),
            spaceVertical(space: 15.h),
            CustomTextField(
                controller: bathroomsController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                hasViewHight: false,
                labelText: "No of bathrooms",
                hintText: "",
                numberOfLines: 1,
                hintFontWeight: FontWeight.w400,
                hintTextColor: colorGray.withOpacity(0.6)),
            spaceVertical(space: 15.h),
            TextView(
                text: "Choose furnishing",
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
                      furnishingValue = "Fully Furnished";
                    });
                  },
                  child: Container(
                    width: 125.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: furnishingValue == "Fully Furnished"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: furnishingValue == "Fully Furnished"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Fully Furnished",
                          color: furnishingValue == "Fully Furnished" ? colorWhite : colorBlack,
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
                      furnishingValue = "Semi Furnished";
                    });
                  },
                  child: Container(
                    width: 135.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: furnishingValue == "Semi Furnished"
                                ? colorPrimary.withOpacity(0.5)
                                : Colors.black),
                        color: furnishingValue == "Semi Furnished"
                            ? colorPrimary.withOpacity(0.5)
                            : colorBg),
                    child: Center(
                      child: TextView(
                          text: "Semi Furnished",
                          color: furnishingValue == "Semi Furnished" ? colorWhite : colorBlack,
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
            return Container(
                height: 40.h,
                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                child: AppSimpleButton(
                  onDoneFuction: () async {
                    if (contactController.text.isEmpty) {
                      showSnackBarError(context, "Invalid Contact Number",
                          "Please enter valid 10 digit contact number");
                    } else if (priceController.text.isEmpty) {
                      showSnackBarError(
                          context, "Invalid Price", "Please enter valid price");
                    } else if (descriptionController.text.isEmpty) {
                      showSnackBarError(context, "Invalid Description",
                          "Please enter valid description");
                    } else if (areaController.text.isEmpty) {
                      showSnackBarError(
                          context, "Invalid Area", "Please enter valid area");
                    } else if (bedroomsController.text.isEmpty) {
                      showSnackBarError(context, "Invalid Bedrooms",
                          "Please enter valid no of bedrooms");
                    } else if (bathroomsController.text.isEmpty) {
                      showSnackBarError(context, "Invalid Bathrooms",
                          "Please enter valid no of bathrooms");
                    } else {
                      
                      AppData.propertyMap["title"] = titleController.text;
                      AppData.propertyMap["contact"] = contactController.text;
                      AppData.propertyMap["description"] =
                          descriptionController.text;
                      AppData.propertyMap["area"] = areaController.text;
                      AppData.propertyMap["price"] = priceController.text;
                      AppData.propertyMap["bedrooms"] = bedroomsController.text;
                      AppData.propertyMap["bathrooms"] =
                          bathroomsController.text;
                      AppData.propertyMap["parking"] = parkingController.text;
                      AppData.propertyMap["furnishing"] = furnishingValue;

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
                ));
          },
        ),
      ),
    );
  }
}
