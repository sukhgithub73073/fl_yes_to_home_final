import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yestohome/src/data/models/current_location_model.dart';
import 'package:yestohome/src/utility/app_util.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<CheckGpsEvent>(_checkGps);
    on<CheckPermissionEvent>(_checkPermission);
    on<GetCurrentLocationEvent>(_getCurrentLocation);
    on<RequestLocationEvent>(_requestLocationPermission);
  }

  Future<FutureOr<void>> _checkGps(
      CheckGpsEvent event, Emitter<LocationState> emit) async {
    debugPrint("LocationBloc>>>>>>>>>>>>>>>>>_checkGps");
    try {
      //emit(LocationLoading());
      var serviceEnabled = await Geolocator.isLocationServiceEnabled();
      debugPrint("LocationBloc>>>>>>>>>>>>>>>>>_checkGps>>>>$serviceEnabled");
      if (serviceEnabled) {
        emit(LocationGpsEnable());
      } else {
        emit(LocationGpsDisable());
      }
    } catch (e) {
      emit(LocationError(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _checkPermission(
      CheckPermissionEvent event, Emitter<LocationState> emit) async {
    debugPrint("LocationBloc>>>>>>>>>>>>>>>>>_checkPermission");

    try {
     // emit(LocationLoading());
      final locationPermission = await Geolocator.checkPermission();
      debugPrint(
          "LocationBloc>>>>>>>>>>>>>>>>>_checkPermission>>>>$locationPermission");

      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) {
        emit(LocationPermisionNotGrant());
      } else {
        emit(LocationPermisionGrant());
      }
    } catch (e) {
      emit(LocationError(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _getCurrentLocation(
      GetCurrentLocationEvent event, Emitter<LocationState> emit) async {
    debugPrint("LocationBloc>>>>>>>>>>>>>>>>>_getCurrentLocation>>>>");

    try {
     // emit(LocationLoading());
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      Placemark place = placemarks[0];
      var _currentAddress =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      debugPrint(
          "LocationBloc>>>>>>>>>>>>>>>>>_getCurrentLocation>>>>$_currentAddress");

      emit(LocationFetch(
          currentLocationModel: CurrentLocationModel(
              latitude: position.latitude,
              longitude: position.longitude,
              location: _currentAddress,
              subLocation: place.country ?? "INDIA")));
    } catch (e) {
      emit(LocationError(error: e.toString()));
      debugPrint(
          "LocationBloc>>>>>>>>>>>>>>>>>_getCurrentLocation>>>>Exception$e");
    }
  }

  Future<FutureOr<void>> _requestLocationPermission(
      RequestLocationEvent event, Emitter<LocationState> emit) async {
    printLog("_requestLocationPermission>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>") ;
  //  emit(LocationLoading());
    var status = await Permission.location.request();
    if (status.isGranted) {
      emit(LocationPermisionGrant());
    } else if (status.isDenied) {
      emit(LocationPermisionNotGrant());
    } else if (status.isPermanentlyDenied) {
      emit(LocationPermisionNotGrant());
    }
  }
}
