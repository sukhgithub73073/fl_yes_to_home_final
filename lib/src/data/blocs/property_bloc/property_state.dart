part of 'property_bloc.dart';

sealed class PropertyState extends Equatable {
  const PropertyState();
}

final class PropertyInitial extends PropertyState {
  @override
  List<Object> get props => [];
}

final class PropertyLoading extends PropertyState {
  @override
  List<Object> get props => [];
}

final class PropertyLoaded extends PropertyState {
  final PropertyModel propertyModel;

  PropertyLoaded({required this.propertyModel});

  @override
  List<Object> get props => [propertyModel];
}

final class PropertyError extends PropertyState {
  final String error;

  PropertyError({required this.error});

  @override
  List<Object> get props => [];
}


final class PropertyCreated extends PropertyState {
  @override
  List<Object> get props => [];
}

