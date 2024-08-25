part of 'property_bloc.dart';

sealed class PropertyEvent extends Equatable {
  const PropertyEvent();
}

class GetPropertyEvent extends PropertyEvent {
  final Map<String, dynamic> map;

  const GetPropertyEvent({required this.map});

  @override
  List<Object?> get props => [map];
}
class CreatePropertyEvent extends PropertyEvent {
  final Map<String, dynamic> map;

  const CreatePropertyEvent({required this.map});

  @override
  List<Object?> get props => [map];
}
