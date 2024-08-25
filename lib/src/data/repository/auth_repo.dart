import 'dart:async';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:yestohome/src/all_getters/table_getter.dart';
import 'package:yestohome/src/data/models/response_model.dart';
import 'package:yestohome/src/utility/app_data.dart';
import 'package:yestohome/src/utility/app_util.dart';

abstract class AuthRepository {
  Future<ResponseModel> loginApi(Map<String, dynamic> map);

  Future<ResponseModel> requestOtpApi(Map<String, dynamic> map);
  Future<ResponseModel> registerApi(Map<String, dynamic> map);
}

class AuthRepositoryImp extends AuthRepository {
  @override
  Future<ResponseModel> loginApi(Map<String, dynamic> map) async {
    ResponseModel responseModel =
        ResponseModel(status: false, data: null, message: "");
    try {
      var usersCollection = AppData.db.collection(tblUsers);
      var user = await usersCollection
          .find(where
              .eq('phone', '${map["phone"]}')
              .eq("password", '${map["password"]}'))
          .toList();
      printLog('>>>>>>>>>>>><<<<<<<<<<<<<<,${jsonEncode(user)}');
      if (user.isNotEmpty) {
        responseModel.status = true;
        responseModel.data = user.first;
      } else {
        responseModel.status = false;
        responseModel.message =
            "Invalid login detail please with correct login details";
      }
    } catch (e) {
      responseModel.status = false;
      responseModel.message = e.toString();
    }
    return responseModel;
  }

  @override
  Future<ResponseModel> registerApi(Map<String, dynamic> map) async {
    ResponseModel responseModel =
        ResponseModel(status: false, data: null, message: "");
    try {
      var usersCollection = AppData.db.collection(tblUsers);
      var user = await usersCollection
          .find(where.eq('phone', '${map["phone"]}'))
          .toList();
      if (user.isEmpty) {
        var res = await usersCollection.insertOne(map);
        map["_id"] = "${res.id}";
        responseModel.status = true;
        responseModel.data = map;
      } else {
        responseModel.status = false;
        responseModel.message =
            "Mobile number already exist please try another mobile number";
      }
    } catch (e) {
      responseModel.status = false;
      responseModel.message = e.toString();
    }
    return responseModel;
  }

  @override
  Future<ResponseModel> requestOtpApi(Map<String, dynamic> map) async {
    ResponseModel responseModel =
        ResponseModel(status: false, data: null, message: "");
    try {
      var usersCollection = AppData.db.collection(tblUsers);
      var user = await usersCollection
          .find(where.eq('phone', '${map["phone"]}'))
          .toList();
      if (user.isEmpty) {

        responseModel.status = true;
      } else {
        responseModel.status = false;
        responseModel.message =
            "Mobile number already exist please try another mobile number";
      }
    } catch (e) {
      responseModel.status = false;
      responseModel.message = e.toString();
    }
    return responseModel;
  }
}
