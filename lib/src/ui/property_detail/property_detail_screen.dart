import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yestohome/src/core/app_colors.dart';
import 'package:yestohome/src/core/app_read_more_text.dart';
import 'package:yestohome/src/core/delivery_time_and_distance_widget.dart';
import 'package:yestohome/src/core/property_name_and_price_widget.dart';
import 'package:yestohome/src/ui/property_detail/property_images.dart';
import 'dart:math';

import '../../data/models/property_model.dart';

class PropertyDetailScreen extends StatefulWidget {
  final Datum datum;

  const PropertyDetailScreen({super.key, required this.datum});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  var textTheme;
  var screenWidth = 0.0;
  int imageIndex = 0;


  @override
  void initState() {
    super.initState();

    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>ddddd???${widget.datum.toJson()}");

    // categoryList = [
    //   CategoryModel(
    //       name: "${widget.datum.bedrooms} Bedrooms",
    //       icon: FontAwesomeIcons.bed,
    //       isSelected: true),
    //   CategoryModel(
    //       name: "${widget.datum.bathrooms} Bathrooms",
    //       icon: FontAwesomeIcons.bath,
    //       isSelected: false),
    //   CategoryModel(
    //       name: "${widget.datum.area} Sq.ft",
    //       icon: FontAwesomeIcons.chartArea,
    //       isSelected: false),
    // ];
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var screenWidth = MediaQuery.sizeOf(context).width * 0.35;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              title: Text(
                "${widget.datum.title}",
                style: textTheme?.labelLarge?.copyWith(fontSize: 18.0),
              ),
              actions: [Icon(Icons.bookmark_border_rounded)],
            ),
            PropertyImages(
              images: widget.datum.imagesList,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0).copyWith(left: 12),
                child: Column(
                  children: [
                    PropertyNameAndPriceWidget(
                        restaurantName: widget.datum.title,
                        price: widget.datum.price),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "${widget.datum.address}",
                          maxLines: 3,
                          style: textTheme.bodyLarge?.copyWith(
                            fontSize: 14.0,
                            color: colorBlack,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DeliveryTimeAndDistanceWidget(
                        deliveryTime: widget.datum.time,
                        distance: widget.datum.distance),
                    Row(
                      children: [
                        Text(
                          "Description",
                          style:
                              textTheme?.labelLarge?.copyWith(fontSize: 18.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: ReadMoreText(
                          '${widget.datum.description}',
                          trimLines: 2,
                          colorClickableText: Colors.pink,
                          style: textTheme.bodyLarge?.copyWith(
                            fontSize: 14.0,
                            color: colorGray.withOpacity(0.8),
                          ),
                          trimMode: TrimMode.Line,
                          trimCollapsedText: ' Show more',
                          trimExpandedText: ' Show less',
                          moreStyle: textTheme.bodyLarge?.copyWith(
                            fontSize: 15.0,
                            color: colorPrimary,
                          ),
                          lessStyle: textTheme.bodyLarge?.copyWith(
                            fontSize: 15.0,
                            color: colorPrimary,
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Overview",
                          style:
                              textTheme?.labelLarge?.copyWith(fontSize: 18.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          "Furnishing : ",
                          style: textTheme?.bodyLarge?.copyWith(fontSize: 14.0),
                        ),
                        Text(
                          "${widget.datum.furnishing}",
                          style:
                              textTheme?.labelLarge?.copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          "Available from : ",
                          style: textTheme?.bodyLarge?.copyWith(fontSize: 14.0),
                        ),
                        Text(
                          "Available now",
                          style:
                              textTheme?.labelLarge?.copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),


                    Row(
                      children: [
                        Text(
                          "Parking : ",
                          style: textTheme?.bodyLarge?.copyWith(fontSize: 14.0),
                        ),
                        Text(
                          "${widget.datum.parking}",
                          style:
                              textTheme?.labelLarge?.copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          "Maintance : ",
                          style: textTheme?.bodyLarge?.copyWith(fontSize: 14.0),
                        ),
                        Text(
                          "1000 per month",
                          style:
                              textTheme?.labelLarge?.copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          "Price Negotiable : ",
                          style: textTheme?.bodyLarge?.copyWith(fontSize: 14.0),
                        ),
                        Text(
                          "No",
                          style:
                              textTheme?.labelLarge?.copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "View on Map",
                          style:
                              textTheme?.labelLarge?.copyWith(fontSize: 18.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: double.maxFinite,
                        child: Image.asset(
                          "assets/images/map_place.jpg",
                          height: 200,
                          fit: BoxFit.fitWidth,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
