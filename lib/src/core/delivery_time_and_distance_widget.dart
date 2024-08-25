import 'package:flutter/material.dart';
import 'package:yestohome/src/core/app_colors.dart';

class DeliveryTimeAndDistanceWidget extends StatelessWidget {
  final String deliveryTime;
  final String distance;
  final Color? textColor;
  final EdgeInsets padding;
  final bool addPadding;

  const DeliveryTimeAndDistanceWidget({
    Key? key,
    required this.deliveryTime,
    required this.distance,
    this.textColor,
    this.padding = EdgeInsets.zero,
    this.addPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: padding == EdgeInsets.zero && addPadding
          ? const EdgeInsets.only(top: 2, bottom: 8)
          : padding,
      child: Row(
        children: [
           Icon(
            Icons.timelapse_rounded,
            color: colorGreen,
            size: 20,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            "$deliveryTime",
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 14,
              color: textColor ?? colorGray.withOpacity(0.8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              Icons.circle,
              size: 5,
              color: textColor ?? colorGray,
            ),
          ),
          Text(
            distance,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 14,
              color: textColor ?? colorGray.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
