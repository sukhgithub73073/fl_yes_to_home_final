import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yestohome/src/core/app_colors.dart';
import 'package:yestohome/src/core/app_text_style.dart';
import 'package:yestohome/src/core/text_view.dart';

void showLoaderDialog(BuildContext context) {

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {

      return AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Loading..."),
            ),
          ],
        ),
      );
    },
  );
}


void printLog(dynamic msg) {
  _printLog('\x1B[32m() => ${msg.toString()}\x1B[0m');
}

void _printLog(dynamic msg) {
  if (kDebugMode) {
    debugPrint(msg.toString());
  }
}

void blocLog({required String msg, required String bloc}) {
  _printLog("\x1B[31m${bloc.toString()} ::==> ${msg.toString()}\x1B[0m");
}

void showSnackBarError(BuildContext context, String title, String message) {

  Get.closeAllSnackbars();
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    titleText: TextView(
      text: "$title",
      color: colorWhite,
      textSize: 15.sp,
      textAlign: TextAlign.start,
      style: AppTextStyleEnum.bold,
      fontFamily: Family.bold,
      lineHeight: 1.3,
    ),
    messageText:  TextView(
      text: "$message",
      color: colorWhite,
      textSize: 13.sp,
      textAlign: TextAlign.start,
      style: AppTextStyleEnum.regular,
      fontFamily: Family.regular,
      lineHeight: 1.3,
    ),
    backgroundColor: colorRed,
  );
}



String getRandomId({required String text}) {
  String cleanString = text.replaceAll(RegExp(r'[^\w\s]'), '');
  String acronym = cleanString
      .split(' ')
      .where((word) => word.isNotEmpty)
      .map((word) => word[0])
      .join('');
  String randomNumber = "${Random().nextInt(90000) + 10000}";
  return acronym + randomNumber.toString();
}
