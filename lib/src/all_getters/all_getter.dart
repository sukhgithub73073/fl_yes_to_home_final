import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

String get cloudinaryUploadPreset => "ml_default";
String get cloudinaryCloudName => "dyyo0zknv";
String get cloudinaryApiKey => "922823335546422";
String get cloudinaryApiSecret => "h0Tp5JmsJGbXWjCMUKLhZdAturw";
String get cloudinaryApiEnvironmentVariable => "CLOUDINARY_URL=cloudinary://922823335546422:h0Tp5JmsJGbXWjCMUKLhZdAturw@dyyo0zknv";


BuildContext get globalBuildContext =>
    GetIt.I.get<GlobalKey<NavigatorState>>().currentContext!;

bool get globalBuildContextExist =>
    GetIt.I.get<GlobalKey<NavigatorState>>().currentContext != null;
