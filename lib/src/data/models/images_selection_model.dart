import 'package:image_picker/image_picker.dart';

class ImagesSelectionModel {
  String assertImage = "";

  XFile? file;

  ImagesSelectionModel({required this.assertImage, this.file});
}
