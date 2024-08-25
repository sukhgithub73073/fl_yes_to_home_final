import 'package:flutter/material.dart';
import 'package:yestohome/src/core/app_colors.dart';

class PropertyNameAndPriceWidget extends StatelessWidget {
  final String restaurantName;
  final String price;
  final double textSize;

  const PropertyNameAndPriceWidget({
    Key? key,
    required this.restaurantName,
    required this.price,
    this.textSize = 17,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            restaurantName,
            maxLines: 1,
            style: textTheme.titleSmall?.copyWith(
              color: colorBlack,
              fontSize: textSize,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.5, vertical: 4),
          decoration: BoxDecoration(
            color: colorGreen,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            "₹ $price",
            style:
                textTheme.titleSmall?.copyWith(color: colorWhite, fontSize: 14),
          ),
        )
      ],
    );
  }
}
