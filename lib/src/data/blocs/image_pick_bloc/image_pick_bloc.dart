import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_pick_event.dart';

part 'image_pick_state.dart';

class ImagePickBloc extends Bloc<ImagePickEvent, ImagePickState> {
  ImagePickBloc() : super(ImagePickInitial()) {
    on<ChangeImagePickEvent>(_onImageChange);
    on<SelectMultiImagePickEvent>(_selectMultiImage);
  }

  Future<FutureOr<void>> _onImageChange(
      ChangeImagePickEvent event, Emitter<ImagePickState> emit) async {
    var file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    emit(ImagePickLoading());
    if (file != null) {
      emit(ImagePickSuccess(file: file));
    } else {
      emit(ImagePickError(error: "Please pick any image"));
    }
  }

  Future<FutureOr<void>> _selectMultiImage(
      SelectMultiImagePickEvent event, Emitter<ImagePickState> emit) async {
    var files = await ImagePicker().pickMultiImage();
    emit(ImagePickLoading());
    if (files != null) {
      emit(ImagePickMultiple(files: files));
    } else {
      emit(ImagePickError(error: "Please pick any image"));
    }
  }
}
