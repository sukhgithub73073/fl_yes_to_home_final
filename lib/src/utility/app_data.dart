import 'package:yestohome/src/data/models/images_selection_model.dart';

class AppData {
  static var db ;
  static List<ImagesSelectionModel> imagesList = [];
  static Map<String, dynamic> propertyMap = {};
  static Map<String, dynamic> homeScreenMap = {};
  static String authToken = "";
  static bool loadMore = true;
}
