import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yestohome/main.dart';
import 'package:yestohome/src/core/app_colors.dart';
import 'package:yestohome/src/core/delivery_time_and_distance_widget.dart';
import 'package:yestohome/src/core/property_name_and_price_widget.dart';
import 'package:yestohome/src/core/text_view.dart';

import '../data/models/property_model.dart';

class PropertyItemWidget extends StatelessWidget {
  final Datum datum;

  const PropertyItemWidget({
    Key? key,
    required this.datum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  datum.imagesList.isNotEmpty
                      ? datum.imagesList.first.image_url
                      : "https://housing-images.n7net.in/01c16c28/045cf6537464d1820dfd867538b1ef21/v0/fs-large/2_bhk_apartment-for-rent-aujala-Mohali-hall.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Positioned(
                  top: 8.h,
                  right: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red),
                    child: TextView(
                        text: "${datum.type}",
                        color: colorWhite,
                        textSize: 13.sp,
                        textAlign: TextAlign.start,
                        style: AppTextStyleEnum.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0).copyWith(left: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PropertyNameAndPriceWidget(
                      restaurantName: datum.title, price: datum.price),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      datum.address,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        color: colorGray.withOpacity(0.8),
                      ),
                    ),
                  ),
                  DeliveryTimeAndDistanceWidget(
                      deliveryTime: "${datum.time}", distance: "${datum.distance}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
