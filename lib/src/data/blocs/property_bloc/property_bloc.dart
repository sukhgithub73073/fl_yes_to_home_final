import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:yestohome/src/data/models/property_model.dart';
import 'package:yestohome/src/data/repository/property_repo.dart';

import '../../models/response_model.dart';

part 'property_event.dart';

part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  var propertyRepository = GetIt.I<PropertyRepository>();

  PropertyBloc() : super(PropertyInitial()) {
    on<GetPropertyEvent>(_getProperty);
    on<CreatePropertyEvent>(_createProperty);
  }

  Future<void> _getProperty(
      GetPropertyEvent event, Emitter<PropertyState> emit) async {
    try {
      List<Datum> list = [];
      if (state is PropertyLoaded) {
        final cast = state as PropertyLoaded;
        list = cast.propertyModel.data ?? <Datum>[];
      }
      if(event.map["pageNo"] == 1){
        list.clear();
      }
      ResponseModel responseModel =
          await propertyRepository.getPropertyApi(event.map);
      PropertyModel model = PropertyModel.fromJson(responseModel.toJson());

      list.addAll(model.data);
      emit(PropertyLoaded(propertyModel: model.copyWith(data: list)));
    } catch (e, t) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>$t");
      emit(PropertyError(error: e.toString()));
    }
  }

  Future<void> _createProperty(
      CreatePropertyEvent event, Emitter<PropertyState> emit) async {
    try {
      List<Datum> list = [];
      if (state is PropertyLoaded) {
        final cast = state as PropertyLoaded;
        list = cast.propertyModel.data ?? <Datum>[];
      }
      emit(PropertyLoading());
      ResponseModel responseModel =
          await propertyRepository.createPropertyApi(event.map);
      emit(responseModel.status
          ? PropertyCreated()
          : PropertyError(error: responseModel.message));
    } catch (e, t) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>$t");
      emit(PropertyError(error: e.toString()));
    }
  }
}
