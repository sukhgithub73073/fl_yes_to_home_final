import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yestohome/src/core/app_colors.dart';
import 'package:yestohome/src/core/app_tap_widget.dart';
import 'package:yestohome/src/core/common_space.dart';
import 'package:yestohome/src/core/text_view.dart';
import 'package:yestohome/src/data/blocs/auth_bloc/auth_bloc.dart';
import 'package:yestohome/src/data/models/property_category_model.dart';
import 'package:yestohome/src/extension/app_extension.dart';
import 'package:yestohome/src/ui/add_property_screens/address_screen.dart';
import 'package:yestohome/src/utility/app_data.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ChooseCategoryScreen extends StatefulWidget {
  const ChooseCategoryScreen({super.key});

  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  var list = [
    PropertyCategoryModel(
        iconData: Icons.home_work_rounded,
        icon: "",
        type: "RENT",
        title: "Rent",
        description:
            "Find residential properties available for short or long-term lease."),
    PropertyCategoryModel(
        iconData: Icons.home_work_rounded,
        icon: "",
        type: "BUY",
        title: "Buy",
        description:
            "Explore opportunities to purchase residential properties."),
    // RentTypeModel(
    //     iconData: Icons.home_work_rounded,
    //     icon: "",
    //     type: "COMMERCIAL",
    //     title: "Commercial",
    //     description:
    //         "Discover spaces for business use, such as offices or retail stores."),
    PropertyCategoryModel(
        iconData: Icons.home_work_rounded,
        icon: "",
        type: "PG",
        title: "PG",
        description:
            "Access with shared living, ideal for students or professionals"),
    PropertyCategoryModel(
        iconData: Icons.home_work_rounded,
        icon: "",
        type: "PLOT",
        title: "Plot",
        description: "Invest in land for development or future use."),
  ];

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
                text: "Step 1/4",
                color: colorMidGray,
                textSize: 13.sp,
                textAlign: TextAlign.center,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 10.h),
            TextView(
                text: "Choose Category",
                color: colorBlack,
                textSize: 16.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.bold),
            spaceVertical(space: 10.h),
            TextView(
                text: "Choose a service here whitch can be changes later on",
                color: colorBlack,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 30.h),
            ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (c, i) {
                  return Card(
                    surfaceTintColor: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    color: colorWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(
                          list[i].iconData,
                          color: colorPrimary,
                        ),
                        title: TextView(
                            text: list[i].title,
                            color: colorBlack,
                            textSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.start,
                            style: AppTextStyleEnum.title),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextView(
                              text: list[i].description,
                              color: colorMidGray,
                              textSize: 12.sp,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w400,
                              style: AppTextStyleEnum.regular),
                        ),
                        onTap: () {
                          AppData.propertyMap["type"] = list[i].type;
                          var state = context.read<AuthBloc>().state;
                          if (state is AuthSuccess) {
                            AppData.propertyMap["vendor_id"] = state.userModel.id ;
                          }
                          context.pushScreen(nextScreen: AddressScreen());
                        },
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
