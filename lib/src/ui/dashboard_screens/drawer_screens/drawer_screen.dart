import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_storage/hive_storage.dart';
import 'package:yestohome/src/core/app_circular_image.dart';
import 'package:yestohome/src/core/app_colors.dart';
import 'package:yestohome/src/core/app_tap_widget.dart';
import 'package:yestohome/src/data/blocs/auth_bloc/auth_bloc.dart';
import 'package:yestohome/src/data/blocs/role_bloc/role_bloc.dart';
import 'package:yestohome/src/enums/role_enum.dart';
import 'package:yestohome/src/extension/app_extension.dart';
import 'package:yestohome/src/ui/auth_screens/login_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  TextTheme? textTheme;
  final baseImageLocation = "assets/images/";

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: ColoredBox(
        color: colorWhiteGhost,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                context.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: colorBlack,
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 155,
                            ),
                            // likesPaymentsSettingsWidget(),
                            // const SizedBox(
                            //   height: 12,
                            // ),

                            listItemLabelWidget(
                              icon: Icons.person_outline_rounded,
                              label: "Your profile",
                              iconSize: 22,
                              extraWidget: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                  color: colorHoneyDew,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "100% completed",
                                  style: textTheme?.labelMedium?.copyWith(
                                    fontSize: 12,
                                    color: colorGreen,
                                  ),
                                ),
                              ),
                              onClick: () {},
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            listItemLabelWidget(
                              icon: Icons.star_border,
                              label: "Your rating",
                              iconSize: 22,
                              extraWidget: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: colorCultured,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "--",
                                      style: textTheme?.labelMedium?.copyWith(
                                        fontSize: 14,
                                        color: colorManatee,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: colorManatee,
                                    ),
                                  ],
                                ),
                              ),
                              onClick: () {},
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: foodOrdersSection(),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 20),
                              child: moreSection(),
                            ),

                            BlocConsumer<RoleBloc, RoleState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return SizedBox();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is AuthSuccess) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: colorWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: colorBlack.withOpacity(0.12),
                                  blurRadius: 10),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TapWidget(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 15),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 15.0),
                                          child: AppCircularImage(
                                            type: "network",
                                            imageLink: state.userModel
                                                    .profileImage.isNotEmpty
                                                ? state.userModel.profileImage
                                                : "https://cdn.pixabay.com/photo/2018/02/08/22/27/flower-3140492_1280.jpg",
                                            radius: 35,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                state.userModel.name,
                                                style: textTheme?.titleSmall
                                                    ?.copyWith(
                                                        fontSize: 26,
                                                        height: 1),
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.zero,
                                                child: Text(
                                                  "+91 ${state.userModel.phone}",
                                                  style: textTheme?.bodyLarge
                                                      ?.copyWith(fontSize: 14),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "View activity",
                                                      style: textTheme
                                                          ?.bodyLarge
                                                          ?.copyWith(
                                                              fontSize: 13,
                                                              color:
                                                                  colorPrimary),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_right,
                                                      size: 16,
                                                      color: colorPrimary,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              TapWidget(
                                onTap: () {
                                  var state = context.read<RoleBloc>().state;
                                  context.read<RoleBloc>().add(ChangeRoleEvent(
                                      roleEnum: state is RolePropertyVendor
                                          ? RoleEnum.propertyUser
                                          : RoleEnum.propertyVendor));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: colorJackoBean,
                                        radius: 20,
                                        child: ClipOval(
                                          child: ShaderMask(
                                            shaderCallback: (bounds) {
                                              return LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  colorSpanishBistre,
                                                  colorDeepChampagne,
                                                  colorSpanishBistre
                                                ],
                                              ).createShader(bounds);
                                            },
                                            blendMode: BlendMode.color,
                                            child: CircleAvatar(
                                              radius: 12,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.5),
                                                child: Image.asset(
                                                  "assets/images/crown_icon.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child:
                                            BlocConsumer<RoleBloc, RoleState>(
                                          listener: (context, state) {},
                                          builder: (context, state) {
                                            return Text(
                                              state is RolePropertyVendor
                                                  ? "Switch User"
                                                  : "Switch Vendor",
                                              style: textTheme?.labelMedium
                                                  ?.copyWith(
                                                      color:
                                                          colorDeepChampagne),
                                            );
                                          },
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: colorDeepChampagne,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget likesPaymentsSettingsWidget() => Row(
        children: [
          clickableIconLabel(
            label: "Likes",
            imageIcon: "assets/images/likes_icon.png",
            onClick: () {
              print("Likes Clicked");
            },
          ),
          const SizedBox(
            width: 12,
          ),
          clickableIconLabel(
            label: "Payments",
            imageIcon: "assets/images/payment_icon.png",
            size: 30,
            onClick: () {
              print("Payments Clicked");
            },
          ),
          const SizedBox(
            width: 12,
          ),
          clickableIconLabel(
            label: "Settings",
            imageIcon: "assets/images/setting_icon.png",
            onClick: () {
              print("Settings Clicked");
            },
          ),
        ],
      );

  Widget clickableIconLabel(
          {required String label,
          required String imageIcon,
          required VoidCallback onClick,
          double size = 25}) =>
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            color: colorWhite,
            child: InkWell(
              onTap: onClick,
              splashColor: colorLightGray,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.asset(
                      imageIcon,
                      height: size,
                      width: size,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      label,
                      style: textTheme?.labelSmall?.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget listItemLabelWidget({
    String? imageIcon,
    IconData? icon,
    required String label,
    Widget? extraWidget,
    double iconSize = 18,
    required VoidCallback onClick,
  }) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          child: InkWell(
            onTap: onClick,
            splashColor: colorLightGray,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: colorCultured,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: imageIcon != null
                          ? Image.asset(
                              imageIcon,
                              fit: BoxFit.fill,
                              height: 18,
                              color: colorManatee,
                            )
                          : Icon(
                              icon,
                              color: colorManatee,
                              size: iconSize,
                            ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        label,
                        style: textTheme?.labelSmall?.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  if (extraWidget != null) extraWidget,
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: colorManatee,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget headerItem({
    required String title,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              height: 25,
              width: 3.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: colorPrimary,
              ),
              margin: const EdgeInsets.only(right: 8),
            ),
            Text(
              title,
              style: textTheme?.labelMedium?.copyWith(fontSize: 16),
            ),
          ],
        ),
      );

  Widget addBorderSection(Widget widget_) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ColoredBox(
          color: colorWhite,
          child: widget_,
        ),
      );

  Widget foodOrdersSection() => addBorderSection(
        BlocConsumer<RoleBloc, RoleState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                headerItem(title: "Orders Management"),
                listItemLabelWidget(
                  label: "Your orders",
                  imageIcon: "${baseImageLocation}delivery_packet_icon.png",
                  onClick: () {},
                ),
                listItemLabelWidget(
                  label: "Favorite orders",
                  imageIcon: "${baseImageLocation}likes_icon.png",
                  onClick: () {},
                ),
                listItemLabelWidget(
                  label: "Address book",
                  imageIcon: "${baseImageLocation}address_icon.png",
                  onClick: () {},
                ),
                listItemLabelWidget(
                  label: "Hidden Restaurants",
                  icon: Icons.visibility_off_outlined,
                  onClick: () {},
                ),
                listItemLabelWidget(
                  label: "Online ordering help",
                  imageIcon: "${baseImageLocation}chat.png",
                  onClick: () {},
                ),
              ],
            );
          },
        ),
      );

  Widget couponsSection() => addBorderSection(
        Column(
          children: [
            headerItem(title: "Coupons"),
            listItemLabelWidget(
              label: "Collected coupons",
              imageIcon: "${baseImageLocation}discount.png",
              extraWidget: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorLavenderBlush,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "new",
                  style: textTheme?.labelMedium?.copyWith(
                    fontSize: 12,
                    color: colorPrimary,
                  ),
                ),
              ),
              onClick: () {},
            ),
          ],
        ),
      );

  Widget tableBookingsSection() => addBorderSection(
        Column(
          children: [
            headerItem(title: "Table Bookings"),
            listItemLabelWidget(
              label: "Your bookings",
              imageIcon: "${baseImageLocation}booked_icon.png",
              onClick: () {},
            ),
            listItemLabelWidget(
              label: "Table booking help",
              imageIcon: "${baseImageLocation}chat.png",
              onClick: () {},
            ),
          ],
        ),
      );

  Widget moneySection() => addBorderSection(
        Column(
          children: [
            headerItem(title: "Money"),
            listItemLabelWidget(
              label: "Buy Gift Card",
              imageIcon: "${baseImageLocation}gift_card_icon.png",
              onClick: () {},
            ),
            listItemLabelWidget(
              label: "Claim Gift Card",
              imageIcon: "${baseImageLocation}claim_gift_cards_icon.png",
              onClick: () {},
            ),
            listItemLabelWidget(
              label: "Gift Card order history",
              icon: Icons.history_toggle_off_rounded,
              onClick: () {},
            ),
            listItemLabelWidget(
              label: "Zomato Credits",
              imageIcon: "${baseImageLocation}zomato_credits_icon.png",
              onClick: () {},
            ),
            listItemLabelWidget(
              label: "Gift Cards help",
              imageIcon: "${baseImageLocation}chat.png",
              onClick: () {},
            ),
          ],
        ),
      );

  Widget moreSection() => addBorderSection(
        Column(
          children: [
            headerItem(title: "More"),
            listItemLabelWidget(
              label: "Choose language",
              imageIcon: "${baseImageLocation}change_language_icon.png",
              onClick: () {},
            ),
            listItemLabelWidget(
              label: "About",
              icon: Icons.info_outline,
              onClick: () {},
            ),
            listItemLabelWidget(
              label: "Send feedback",
              icon: Icons.edit_square,
              onClick: () {},
            ),
            listItemLabelWidget(
              label: "Report a safety emergency",
              icon: Icons.error_outline,
              onClick: () {},
            ),
            listItemLabelWidget(
              label: "Log out",
              icon: Icons.power_settings_new_rounded,
              onClick: () {
                getHiveStorage.write(key: "LOGIN_RESPONSE", value: "");
                context.pushReplacementScreen(nextScreen: LoginScreen());
              },
            ),
          ],
        ),
      );
}
