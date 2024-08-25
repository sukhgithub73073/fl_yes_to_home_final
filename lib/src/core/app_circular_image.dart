import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCircularImage extends StatelessWidget {
  final String imageLink;
  final double radius;
  final String type;

  const AppCircularImage({
    Key? key,
    required this.imageLink,
    this.radius = 12,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageLink == ""
        ? CircleAvatar(
            radius: radius,
            backgroundImage: AssetImage(
                "assets/images/add_dummy.png") // Load image from file
            )
        : type == "file"
            ? CircleAvatar(
                radius: radius,
                backgroundImage:
                    FileImage(File(imageLink)) // Load image from file
                )
            : CircleAvatar(
                radius: radius,
                backgroundImage: CachedNetworkImageProvider(
                    imageLink), // Load image from network
              );
  }
}
