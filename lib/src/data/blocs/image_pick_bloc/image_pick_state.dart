part of 'image_pick_bloc.dart';

sealed class ImagePickState extends Equatable {
  const ImagePickState();
}

final class ImagePickInitial extends ImagePickState {
  @override
  List<Object> get props => [];
}

final class ImagePickLoading extends ImagePickState {
  @override
  List<Object> get props => [];
}

final class ImagePickSuccess extends ImagePickState {
  final XFile file;

  ImagePickSuccess({required this.file});

  @override
  List<Object> get props => [file];
}

final class ImagePickMultiple extends ImagePickState {
  final List<XFile> files;

  ImagePickMultiple({required this.files});

  @override
  List<Object> get props => [files];
}

final class ImagePickError extends ImagePickState {
  final String error;

  ImagePickError({required this.error});

  @override
  List<Object> get props => [error];
}
