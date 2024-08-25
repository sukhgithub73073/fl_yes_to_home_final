import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yestohome/src/core/app_button.dart';
import 'package:yestohome/src/core/app_colors.dart';
import 'package:yestohome/src/core/app_input_field.dart';
import 'package:yestohome/src/core/app_tap_widget.dart';
import 'package:yestohome/src/core/common_space.dart';
import 'package:yestohome/src/core/text_view.dart';
import 'package:yestohome/src/data/blocs/location_bloc/location_bloc.dart';
import 'package:yestohome/src/data/models/property_model.dart';
import 'package:yestohome/src/extension/app_extension.dart';
import 'package:yestohome/src/ui/add_property_screens/information_screen.dart';
import 'package:yestohome/src/ui/add_property_screens/information_screen_buy.dart';
import 'package:yestohome/src/ui/add_property_screens/information_screen_pg.dart';
import 'package:yestohome/src/ui/add_property_screens/information_screen_plot.dart';
import 'package:yestohome/src/utility/app_data.dart';
import 'package:yestohome/src/utility/app_util.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> filteredAddresses = [];
  final List<Map<String, dynamic>> locations = [
    {"name": "Sector 1, Chandigarh", "lat": 30.7530, "lng": 76.7758},
    {"name": "Sector 2, Chandigarh", "lat": 30.7520, "lng": 76.7839},
    {"name": "Sector 3, Chandigarh", "lat": 30.7502, "lng": 76.7921},
    {"name": "Sector 4, Chandigarh", "lat": 30.7466, "lng": 76.8012},
    {"name": "Sector 5, Chandigarh", "lat": 30.7424, "lng": 76.8092},
    {"name": "Sector 6, Chandigarh", "lat": 30.7383, "lng": 76.8168},
    {"name": "Sector 7, Chandigarh", "lat": 30.7343, "lng": 76.8234},
    {"name": "Sector 8, Chandigarh", "lat": 30.7302, "lng": 76.8299},
    {"name": "Sector 9, Chandigarh", "lat": 30.7261, "lng": 76.8362},
    {"name": "Sector 10, Chandigarh", "lat": 30.7219, "lng": 76.8419},
    {"name": "Sector 11, Chandigarh", "lat": 30.7178, "lng": 76.8474},
    {"name": "Sector 12, Chandigarh", "lat": 30.7136, "lng": 76.8529},
    {"name": "Sector 13, Chandigarh", "lat": 30.7095, "lng": 76.8579},
    {"name": "Sector 14, Chandigarh", "lat": 30.7054, "lng": 76.8630},
    {"name": "Sector 15, Chandigarh", "lat": 30.7013, "lng": 76.8680},
    {"name": "Sector 16, Chandigarh", "lat": 30.6972, "lng": 76.8727},
    {"name": "Sector 17, Chandigarh", "lat": 30.6931, "lng": 76.8774},
    {"name": "Sector 18, Chandigarh", "lat": 30.6890, "lng": 76.8819},
    {"name": "Sector 19, Chandigarh", "lat": 30.6849, "lng": 76.8863},
    {"name": "Sector 20, Chandigarh", "lat": 30.6808, "lng": 76.8906},
    {"name": "Sector 21, Chandigarh", "lat": 30.6767, "lng": 76.8948},
    {"name": "Sector 22, Chandigarh", "lat": 30.6726, "lng": 76.8989},
    {"name": "Sector 23, Chandigarh", "lat": 30.6685, "lng": 76.9029},
    {"name": "Sector 24, Chandigarh", "lat": 30.6644, "lng": 76.9068},
    {"name": "Sector 25, Chandigarh", "lat": 30.6603, "lng": 76.9106},
    {"name": "Sector 26, Chandigarh", "lat": 30.6562, "lng": 76.9143},
    {"name": "Sector 27, Chandigarh", "lat": 30.6521, "lng": 76.9179},
    {"name": "Sector 28, Chandigarh", "lat": 30.6480, "lng": 76.9214},
    {"name": "Sector 29, Chandigarh", "lat": 30.6439, "lng": 76.9248},
    {"name": "Sector 30, Chandigarh", "lat": 30.6398, "lng": 76.9281},
    {"name": "Sector 31, Chandigarh", "lat": 30.6357, "lng": 76.9313},
    {"name": "Sector 32, Chandigarh", "lat": 30.6316, "lng": 76.9344},
    {"name": "Sector 33, Chandigarh", "lat": 30.6275, "lng": 76.9374},
    {"name": "Sector 34, Chandigarh", "lat": 30.6234, "lng": 76.9403},
    {"name": "Sector 35, Chandigarh", "lat": 30.6193, "lng": 76.9431},
    {"name": "Sector 36, Chandigarh", "lat": 30.6152, "lng": 76.9458},
    {"name": "Sector 37, Chandigarh", "lat": 30.6111, "lng": 76.9484},
    {"name": "Sector 38, Chandigarh", "lat": 30.6070, "lng": 76.9510},
    {"name": "Sector 39, Chandigarh", "lat": 30.6029, "lng": 76.9534},
    {"name": "Sector 40, Chandigarh", "lat": 30.5988, "lng": 76.9558},
    {"name": "Sector 41, Chandigarh", "lat": 30.5947, "lng": 76.9581},
    {"name": "Sector 42, Chandigarh", "lat": 30.5906, "lng": 76.9603},
    {"name": "Sector 43, Chandigarh", "lat": 30.5865, "lng": 76.9624},
    {"name": "Sector 44, Chandigarh", "lat": 30.5824, "lng": 76.9644},
    {"name": "Sector 45, Chandigarh", "lat": 30.5783, "lng": 76.9663},
    {"name": "Sector 46, Chandigarh", "lat": 30.5742, "lng": 76.9681},
    {"name": "Sector 47, Chandigarh", "lat": 30.5701, "lng": 76.9699},
    {"name": "Sector 48, Chandigarh", "lat": 30.5660, "lng": 76.9716},
    {"name": "Sector 49, Chandigarh", "lat": 30.5619, "lng": 76.9732},
    {"name": "Sector 50, Chandigarh", "lat": 30.5578, "lng": 76.9747},
    {"name": "Sector 51, Chandigarh", "lat": 30.5537, "lng": 76.9761},
    {"name": "Sector 52, Chandigarh", "lat": 30.5496, "lng": 76.9775},
    {"name": "Sector 53, Chandigarh", "lat": 30.5455, "lng": 76.9787},
    {"name": "Sector 54, Chandigarh", "lat": 30.5414, "lng": 76.9799},
    {"name": "Sector 55, Chandigarh", "lat": 30.5373, "lng": 76.9810},
    {"name": "Sector 56, Chandigarh", "lat": 30.5332, "lng": 76.9820},
    {"name": "Sector 57, Chandigarh", "lat": 30.5291, "lng": 76.9829},
    {"name": "Sector 58, Chandigarh", "lat": 30.5250, "lng": 76.9838},
    {"name": "Sector 59, Chandigarh", "lat": 30.5209, "lng": 76.9845},
    {"name": "Sector 60, Chandigarh", "lat": 30.5168, "lng": 76.9852},
    {"name": "Sector 61, Chandigarh", "lat": 30.5127, "lng": 76.9858},
    {"name": "Sector 62, Chandigarh", "lat": 30.5086, "lng": 76.9863},
    {"name": "Sector 63, Chandigarh", "lat": 30.5045, "lng": 76.9867},
    {"name": "Sector 64, Chandigarh", "lat": 30.5004, "lng": 76.9870},
    {"name": "Sector 65, Chandigarh", "lat": 30.4963, "lng": 76.9873},
    {"name": "Sector 66, Chandigarh", "lat": 30.4922, "lng": 76.9874},
    {"name": "Sector 67, Chandigarh", "lat": 30.4881, "lng": 76.9875},
    {"name": "Sector 68, Chandigarh", "lat": 30.4840, "lng": 76.9875},
    {"name": "Sector 69, Chandigarh", "lat": 30.4799, "lng": 76.9874},
    {"name": "Sector 70, Chandigarh", "lat": 30.4758, "lng": 76.9872},
    {"name": "Sector 71, Chandigarh", "lat": 30.4717, "lng": 76.9869},
    {"name": "Sector 72, Chandigarh", "lat": 30.4676, "lng": 76.9866},
    {"name": "Sector 73, Chandigarh", "lat": 30.4635, "lng": 76.9861},
    {"name": "Sector 74, Chandigarh", "lat": 30.4594, "lng": 76.9856},
    {"name": "Sector 75, Chandigarh", "lat": 30.4553, "lng": 76.9850},
    {"name": "Sector 76, Chandigarh", "lat": 30.4512, "lng": 76.9843},
    {"name": "Sector 77, Chandigarh", "lat": 30.4471, "lng": 76.9835},
    {"name": "Sector 78, Chandigarh", "lat": 30.4430, "lng": 76.9826},
    {"name": "Sector 79, Chandigarh", "lat": 30.4389, "lng": 76.9816},
    {"name": "Sector 80, Chandigarh", "lat": 30.4348, "lng": 76.9806},
    {"name": "Sector 81, Chandigarh", "lat": 30.4307, "lng": 76.9794},
    {"name": "Sector 82, Chandigarh", "lat": 30.4266, "lng": 76.9782},
    {"name": "Sector 83, Chandigarh", "lat": 30.4225, "lng": 76.9768},
    {"name": "Sector 84, Chandigarh", "lat": 30.4184, "lng": 76.9754},
    {"name": "Sector 85, Chandigarh", "lat": 30.4143, "lng": 76.9739},
    {"name": "Sector 86, Chandigarh", "lat": 30.4102, "lng": 76.9723},
    {"name": "Sector 87, Chandigarh", "lat": 30.4061, "lng": 76.9706},
    {"name": "Sector 88, Chandigarh", "lat": 30.4020, "lng": 76.9688},
    {"name": "Sector 89, Chandigarh", "lat": 30.3979, "lng": 76.9670},
    {"name": "Sector 90, Chandigarh", "lat": 30.3938, "lng": 76.9650},
    {"name": "Sector 91, Chandigarh", "lat": 30.3897, "lng": 76.9629},
    {"name": "Sector 92, Chandigarh", "lat": 30.3856, "lng": 76.9608},
    {"name": "Sector 93, Chandigarh", "lat": 30.3815, "lng": 76.9585},
    {"name": "Sector 94, Chandigarh", "lat": 30.3774, "lng": 76.9561},
    {"name": "Sector 95, Chandigarh", "lat": 30.3733, "lng": 76.9537},
    {"name": "Sector 96, Chandigarh", "lat": 30.3692, "lng": 76.9511},
    {"name": "Sector 97, Chandigarh", "lat": 30.3651, "lng": 76.9485},
    {"name": "Sector 98, Chandigarh", "lat": 30.3610, "lng": 76.9458},
    {"name": "Sector 99, Chandigarh", "lat": 30.3569, "lng": 76.9429},
    {"name": "Sector 100, Chandigarh", "lat": 30.3528, "lng": 76.9399},
    {"name": "Sector 101, Chandigarh", "lat": 30.3487, "lng": 76.9369},
    {"name": "Sector 102, Chandigarh", "lat": 30.3446, "lng": 76.9338},
    {"name": "Sector 103, Chandigarh", "lat": 30.3405, "lng": 76.9305},
    {"name": "Sector 104, Chandigarh", "lat": 30.3364, "lng": 76.9272},
    {"name": "Sector 105, Chandigarh", "lat": 30.3323, "lng": 76.9237},
    {"name": "Sector 106, Chandigarh", "lat": 30.3282, "lng": 76.9202},
    {"name": "Sector 107, Chandigarh", "lat": 30.3241, "lng": 76.9166},
    {"name": "Sector 108, Chandigarh", "lat": 30.3200, "lng": 76.9129},
    {"name": "Sector 109, Chandigarh", "lat": 30.3159, "lng": 76.9091},
    {"name": "Sector 110, Chandigarh", "lat": 30.3118, "lng": 76.9052},
    {"name": "Sector 111, Chandigarh", "lat": 30.3077, "lng": 76.9012},
    {"name": "Sector 112, Chandigarh", "lat": 30.3036, "lng": 76.8971},
    {"name": "Sector 113, Chandigarh", "lat": 30.2995, "lng": 76.8930},
    {"name": "Sector 114, Chandigarh", "lat": 30.2954, "lng": 76.8887},
    {"name": "Sector 115, Chandigarh", "lat": 30.2913, "lng": 76.8844},
    {"name": "Sector 116, Chandigarh", "lat": 30.2872, "lng": 76.8799},
    {"name": "Sector 117, Chandigarh", "lat": 30.2831, "lng": 76.8754},
    {"name": "Sector 118, Chandigarh", "lat": 30.2790, "lng": 76.8708},
    {"name": "Sector 119, Chandigarh", "lat": 30.2749, "lng": 76.8661},
    {"name": "Sector 120, Chandigarh", "lat": 30.2708, "lng": 76.8613},
    {"name": "Sector 121, Chandigarh", "lat": 30.2667, "lng": 76.8564},
    {"name": "Sector 122, Chandigarh", "lat": 30.2626, "lng": 76.8514},
    {"name": "Sector 123, Chandigarh", "lat": 30.2585, "lng": 76.8463},
    {"name": "Sector 124, Chandigarh", "lat": 30.2544, "lng": 76.8411},
    {"name": "Sector 125, Chandigarh", "lat": 30.2503, "lng": 76.8358},
    {"name": "Sector 126, Chandigarh", "lat": 30.2462, "lng": 76.8304},
    {"name": "Sector 127, Chandigarh", "lat": 30.2421, "lng": 76.8249},
    {"name": "Sector 128, Chandigarh", "lat": 30.2380, "lng": 76.8193},
    {"name": "Sector 129, Chandigarh", "lat": 30.2339, "lng": 76.8136},
    {"name": "Sector 130, Chandigarh", "lat": 30.2298, "lng": 76.8078},
    {"name": "Sector 131, Chandigarh", "lat": 30.2257, "lng": 76.8019},
    {"name": "Sector 132, Chandigarh", "lat": 30.2216, "lng": 76.7959},
    {"name": "Sector 133, Chandigarh", "lat": 30.2175, "lng": 76.7898},
    {"name": "Sector 134, Chandigarh", "lat": 30.2134, "lng": 76.7836},
    {"name": "Sector 135, Chandigarh", "lat": 30.2093, "lng": 76.7773}
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
                text: AppData.propertyMap["type"] == "PG"
                    ? "Step 2/5"
                    : "Step 2/4",
                color: colorMidGray,
                textSize: 13.sp,
                textAlign: TextAlign.center,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 10.h),
            TextView(
                text: "Choose Address",
                color: colorBlack,
                textSize: 16.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.bold),
            spaceVertical(space: 10.h),
            TextView(
                text:
                    "Located on the picturesque shorelines, our address offers stunning ocean views",
                color: colorBlack,
                textSize: 13.sp,
                textAlign: TextAlign.start,
                style: AppTextStyleEnum.regular),
            spaceVertical(space: 30.h),
            CustomTextField(
              controller: _controller,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              hasViewHight: false,
              labelText: "Enter Complete Address",
              hintText: "Complete address",
              numberOfLines: 1,
              hintFontWeight: FontWeight.w400,
              hintTextColor: colorGray.withOpacity(0.6),
              preffixicon: Icon(Icons.location_on_outlined),
            ),
            spaceVertical(space: 10.h),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: filteredAddresses.length,
            //     itemBuilder: (context, index) {
            //       final location = filteredAddresses[index];
            //       return ListTile(
            //         onTap: () {
            //           if (AppData.propertyMap["type"] == "RENT") {
            //             context.pushScreen(nextScreen: InformationScreen());
            //           } else if (AppData.propertyMap["type"] == "BUY") {
            //             context.pushScreen(nextScreen: InformationScreenBuy());
            //           } else if (AppData.propertyMap["type"] == "PG") {
            //             context.pushScreen(nextScreen: InformationScreenPG());
            //           } else if (AppData.propertyMap["type"] == "PLOT") {
            //             context.pushScreen(nextScreen: InformationScreenPlot());
            //           }
            //         },
            //         title: Text(location['name']),
            //         subtitle: Text(
            //             "Lat: ${location['lat']}, Lng: ${location['lng']}"),
            //       );
            //     },
            //   ),
            // ),
            // spaceVertical(space: 10.h),
            TapWidget(
              onTap: () {
                var locationState = context.read<LocationBloc>().state;
                if (locationState is LocationFetch) {
                  var loc = Location(type: "Point", coordinates: [
                    locationState.currentLocationModel.longitude,
                    locationState.currentLocationModel.latitude
                  ]);
                  AppData.propertyMap["location"] = loc.toJson();
                  AppData.propertyMap["address"] =
                      locationState.currentLocationModel.location;
                }

                if (AppData.propertyMap["type"] == "RENT") {
                  context.pushScreen(nextScreen: InformationScreen());
                } else if (AppData.propertyMap["type"] == "BUY") {
                  context.pushScreen(nextScreen: InformationScreenBuy());
                } else if (AppData.propertyMap["type"] == "PG") {
                  context.pushScreen(nextScreen: InformationScreenPG());
                } else if (AppData.propertyMap["type"] == "PLOT") {
                  context.pushScreen(nextScreen: InformationScreenPlot());
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.my_location,
                    color: colorPrimary,
                  ),
                  spaceHorizontal(space: 5.w),
                  TextView(
                      text: "Use my current location",
                      color: colorPrimary,
                      textSize: 14.sp,
                      textAlign: TextAlign.start,
                      style: AppTextStyleEnum.title),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 40.h,
        margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
        child: AppSimpleButton(
          onDoneFuction: () async {
            if (_controller.text.isEmpty) {
              showSnackBarError(
                  context, "Invalid address", "Please enter valid address");
            } else {
              var locationState = context.read<LocationBloc>().state;
              if (locationState is LocationFetch) {
                var loc = Location(type: "Point", coordinates: [
                  locationState.currentLocationModel.longitude,
                  locationState.currentLocationModel.latitude
                ]);
                AppData.propertyMap["location"] = loc.toJson();
                AppData.propertyMap["address"] =
                    locationState.currentLocationModel.location;
              }

              if (AppData.propertyMap["type"] == "RENT") {
                context.pushScreen(nextScreen: InformationScreen());
              } else if (AppData.propertyMap["type"] == "BUY") {
                context.pushScreen(nextScreen: InformationScreenBuy());
              } else if (AppData.propertyMap["type"] == "PG") {
                context.pushScreen(nextScreen: InformationScreenPG());
              } else if (AppData.propertyMap["type"] == "PLOT") {
                context.pushScreen(nextScreen: InformationScreenPlot());
              }
            }
          },
          buttonBackgroundColor: colorPrimary,
          nameText: "Next",
          textSize: 18.sp,
        ),
      ),
    );
  }
}
