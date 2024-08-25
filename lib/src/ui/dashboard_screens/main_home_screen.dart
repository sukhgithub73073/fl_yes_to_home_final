import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yestohome/main.dart';
import 'package:yestohome/src/core/app_circular_image.dart';
import 'package:yestohome/src/core/app_colors.dart';
import 'package:yestohome/src/core/app_tap_widget.dart';
import 'package:yestohome/src/core/property_item.dart';
import 'package:yestohome/src/core/search_bar_widget.dart';
import 'package:yestohome/src/data/blocs/auth_bloc/auth_bloc.dart';
import 'package:yestohome/src/data/blocs/location_bloc/location_bloc.dart';
import 'package:yestohome/src/data/blocs/property_bloc/property_bloc.dart';
import 'package:yestohome/src/data/blocs/role_bloc/role_bloc.dart';
import 'package:yestohome/src/enums/role_enum.dart';
import 'package:yestohome/src/extension/app_extension.dart';
import 'package:yestohome/src/ui/add_property_screens/choose_category_screen.dart';
import 'package:yestohome/src/ui/dashboard_screens/drawer_screens/drawer_screen.dart';
import 'package:yestohome/src/ui/property_detail/property_detail_screen.dart';
import 'package:yestohome/src/utility/app_data.dart';
import 'package:yestohome/src/utility/app_util.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  @override
  void initState() {
    super.initState();

    var locationState = context.read<LocationBloc>().state ;
    if(locationState is LocationFetch){}else{
      context.read<LocationBloc>().add(CheckGpsEvent());
    }


    AppData.homeScreenMap["pageNo"] = 1;
    AppData.homeScreenMap["search_query"] = "";
    var authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      if (authState.userModel.userType == RoleEnum.propertyVendor.name) {
        AppData.homeScreenMap["vendor_id"] = authState.userModel.id;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PreferredSize(
                preferredSize: const Size.fromHeight(55),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: colorPrimary,
                        size: 25,
                      ),
                      Expanded(
                        child: BlocConsumer<LocationBloc, LocationState>(
                          listenWhen: (previous, current) {
                            return previous != current;
                          },
                          listener: (context, state) {
                            printLog(
                                "sssssssssssssssssssssssssssssssssssss>>>>>LocationBloc>>${state.toString()}");

                            if (state is LocationGpsDisable) {
                            } else if (state is LocationGpsEnable) {
                              context
                                  .read<LocationBloc>()
                                  .add(CheckPermissionEvent());
                            } else if (state is LocationPermisionNotGrant) {
                              context
                                  .read<LocationBloc>()
                                  .add(RequestLocationEvent());
                            } else if (state is LocationPermisionGrant) {
                              context
                                  .read<LocationBloc>()
                                  .add(GetCurrentLocationEvent());
                            } else if (state is LocationFetch) {
                              AppData.homeScreenMap["latitude"] =
                                  state.currentLocationModel.latitude;
                              AppData.homeScreenMap["longitude"] =
                                  state.currentLocationModel.longitude;
                              // AppData.homeScreenMap["type"] = "";
                              AppData.homeScreenMap["search_query"] = "";
                              printLog("PropertyBloc>>>>>>>>>>>call>>LocationFetch");

                              context.read<PropertyBloc>().add(
                                  GetPropertyEvent(map: AppData.homeScreenMap));
                            }
                          },
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: Text(
                                        state is LocationFetch
                                            ? state
                                                .currentLocationModel.location
                                            : "Fetching location...",
                                        style: textTheme.labelSmall?.copyWith(
                                          color: colorBlack,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushScreen(nextScreen: DrawerScreen());
                        },
                        child: AppCircularImage(
                          type: "network",
                          imageLink:
                              "https://cdn.pixabay.com/photo/2018/02/08/22/27/flower-3140492_1280.jpg",
                          radius: 19,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverAppBar(
              title: SearchBarWidget(
                controller: TextEditingController(),
                iconData: Icons.filter_list,
                onChanged: (e) {

                  printLog("PropertyBloc>>>>>>>>>>>call>>onChanged");

                  AppData.homeScreenMap["search_query"] = e;
                  context
                      .read<PropertyBloc>()
                      .add(GetPropertyEvent(map: AppData.homeScreenMap));
                },
                leadingIcon: IconButton(
                    onPressed: () {}, icon: Icon(Icons.search_rounded)),
                trailingIcon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
                hint: "Search for landmark or builder...",
                onClick: () {
                  //Navigator.pushNamed(context, SearchScreen.routeName);
                },
                hintColor: colorMidGray,
              ),
              automaticallyImplyLeading: false,
              backgroundColor: colorWhite,
              elevation: 0,
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
            BlocConsumer<PropertyBloc, PropertyState>(
              listener: (context, state) {
                printLog(
                    "PropertyBloc>>>>>>>>>>>listener>>${state.toString()}");
              },
              builder: (context, state) {
                if (state is PropertyLoading) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is PropertyLoaded) {
                  return state.propertyModel.data.isEmpty
                      ? SliverToBoxAdapter(
                          child: Center(
                              child: Image.asset("assets/images/no_data.png")))
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return TapWidget(
                                onTap: () async {
                                  context.pushScreen(
                                      nextScreen: PropertyDetailScreen(
                                    datum: state.propertyModel.data[index],
                                  ));
                                },
                                child: PropertyItemWidget(
                                  datum: state.propertyModel.data[index],
                                ),
                              );
                            },
                            childCount: state.propertyModel.data
                                .length, // Adjust according to your state
                          ),
                        );
                } else {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Loading....')),
                  );
                }
              },
            ),
          ],
        ),
        floatingActionButton: _floatingActionButton(),
      ),
    );
  }

  _floatingActionButton() {
    return BlocConsumer<RoleBloc, RoleState>(
      listener: (context, state) {},
      builder: (context, state) {
        return (state is RolePropertyVendor)
            ? FloatingActionButton(
                onPressed: () {
                  AppData.propertyMap = {};
                  context.pushScreen(nextScreen: ChooseCategoryScreen());
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: colorPrimary, // Customize background color
              )
            : SizedBox.shrink();
      },
    );
  }
}
