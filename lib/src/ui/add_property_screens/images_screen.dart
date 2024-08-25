import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yestohome/src/core/app_button.dart';
import 'package:yestohome/src/core/app_colors.dart';
import 'package:yestohome/src/core/app_dialog.dart';
import 'package:yestohome/src/core/app_input_field.dart';
import 'package:yestohome/src/core/app_tap_widget.dart';
import 'package:yestohome/src/core/common_space.dart';
import 'package:yestohome/src/core/dialog_widgets/failure_message_dialog.dart';
import 'package:yestohome/src/core/dialog_widgets/success_message_dialog.dart';
import 'package:yestohome/src/core/text_view.dart';
import 'package:yestohome/src/data/blocs/auth_bloc/auth_bloc.dart';
import 'package:yestohome/src/data/blocs/image_pick_bloc/image_pick_bloc.dart';
import 'package:yestohome/src/data/blocs/property_bloc/property_bloc.dart';
import 'package:yestohome/src/data/models/images_selection_model.dart';
import 'package:yestohome/src/extension/app_extension.dart';
import 'package:yestohome/src/ui/add_property_screens/images_screen.dart';
import 'package:yestohome/src/ui/dashboard_screens/main_home_screen.dart';
import 'package:yestohome/src/utility/app_data.dart';
import 'package:yestohome/src/utility/app_util.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  @override
  void initState() {
    super.initState();
    AppData.imagesList = [
      ImagesSelectionModel(
          assertImage: "assets/images/placeholder_images.png", file: null)
    ];
  }

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
          children: [
            TextView(
                text: AppData.propertyMap["type"] == "PG"
                    ? "Step 5/5"
                    : "Step 4/4",
                color: colorMidGray,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 10.h),
            TextView(
                text: "Choose Images",
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
            BlocConsumer<ImagePickBloc, ImagePickState>(
              listener: (context, state) {
                if (state is ImagePickMultiple) {
                  printLog(
                      "ImagePickMultiple>>>>>>>>>>>>>>>>>${state.files.length}");

                  for (var file in state.files) {
                    AppData.imagesList
                        .add(ImagesSelectionModel(assertImage: "", file: file));
                  }

                  setState(() {});
                }
              },
              builder: (context, state) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemCount: AppData.imagesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AppData.imagesList[index].assertImage != ""
                        ? TapWidget(
                            onTap: () {
                              context
                                  .read<ImagePickBloc>()
                                  .add(SelectMultiImagePickEvent());
                            },
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: Colors.black,
                              strokeWidth: 1,
                              child: Image.asset(
                                height: 130.h,
                                AppData.imagesList[index].assertImage,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              Image.file(
                                height: 130.h,
                                width: double.maxFinite,
                                File(
                                    AppData.imagesList[index].file?.path ?? ""),
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                right: 5.w,
                                top: 2.h,
                                child: TapWidget(
                                  onTap: () {
                                    setState(() {
                                      AppData.imagesList.removeAt(index);
                                      if (AppData.imagesList.length == 7) {
                                        AppData.imagesList.insert(
                                            0,
                                            ImagesSelectionModel(
                                                assertImage:
                                                    "assets/images/choose_images_placeholder.png",
                                                file: null));
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 25.h,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.withOpacity(0.3),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocListener<PropertyBloc, PropertyState>(
        listener: (context, state) {
          if (state is PropertyLoading) {
            showLoaderDialog(context);
          } else if (state is PropertyCreated) {
            context.back();
            appDialog(
                context: context,
                child: SuccessDailog(
                  title: "Successfully",
                  onTap: () {
                    context.pushReplacementScreen(nextScreen: MainHomeScreen());
                  },
                  message: "Your property added sucessfully",
                ));
          } else if (state is PropertyError) {
            context.back();
            appDialog(
                context: context,
                child: ErrorDailog(
                  title: "Failed",
                  onTap: () {
                    context.back();
                  },
                  message: "${state.error}",
                ));
          }
        },
        child: Container(
            height: 40.h,
            margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
            child: AppSimpleButton(
              onDoneFuction: () async {
                if (AppData.imagesList.length > 1) {
                  // AppData.propertyMap["files"] = AppData.imagesList
                  //     .where((element) => element.file != null);
                  context
                      .read<PropertyBloc>()
                      .add(CreatePropertyEvent(map: AppData.propertyMap));
                } else {
                  showSnackBarError(
                      context, "Invalid Images", "Please select a image");
                }
              },
              buttonBackgroundColor: colorPrimary,
              nameText: "Submit",
              textSize: 18.sp,
            )),
      ),
    );
  }
}
