import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:yestohome/src/all_getters/all_getter.dart';
import 'package:yestohome/src/all_getters/table_getter.dart';
import 'package:yestohome/src/data/models/images_selection_model.dart';
import 'package:yestohome/src/data/models/property_model.dart';
import 'package:yestohome/src/data/models/response_model.dart';
import 'package:yestohome/src/utility/app_data.dart';
import 'package:yestohome/src/utility/app_util.dart';
import 'package:yestohome/src/utility/distance_util.dart';

abstract class PropertyRepository {
  Future<ResponseModel> getPropertyApi(Map<String, dynamic> map);

  Future<ResponseModel> createPropertyApi(Map<String, dynamic> map);
}

class PropertyRepositoryImp extends PropertyRepository {
  @override
  Future<ResponseModel> getPropertyApi(Map<String, dynamic> map) async {
    var pageSize = 7;
    printLog("getPropertyApi>>>>>>>>>>>>>>>>>>>>>>>>>>.${map}");
    var propertyCollection = AppData.db.collection(tblProperty);
    await propertyCollection.createIndex(
      keys: {
        'location': '2dsphere',
      },
      unique: false,
      sparse: true,
    );

    Map<String, dynamic> query = {};

    if (map.containsKey("type")) {
      query['type'] = map['type'];
    }

    if (map.containsKey("vendor_id")) {
      query['vendor_id'] = map['vendor_id'];
    }
    // Add search functionality for 'name' or 'address'
    if (map.containsKey('search_query') && map["search_query"] != "") {
      String searchTerm = map['search_query'];

      query['\$or'] = [
        {
          'title': {'\$regex': searchTerm, '\$options': 'i'}
        },
        {
          'address': {'\$regex': searchTerm, '\$options': 'i'}
        }
      ];

    }

    int skip = 0;

    try {
      skip = (map["pageNo"] - 1) * pageSize;
    } catch (e) {
      print(e);
    }
    int limit = pageSize;

    var pipeline = AggregationPipelineBuilder()
        .addStage(GeoNear(
            near: Geometry(
                type: GeometryObjectType.Point,
                coordinates: map.containsKey("longitude")
                    ? [map["longitude"], map["latitude"]]
                    : []),
            distanceField: "distance"))
        .addStage(Match(query))
        .addStage(Sort({"created_at": -1}))
        .addStage(Lookup(
            from: tblPropertyImages,
            localField: '_id',
            foreignField: 'property_id',
            as: 'imagesList'))
        .addStage(Skip(skip))
        .addStage(Limit(limit))
        .build();
    var results = await propertyCollection.aggregateToStream(pipeline).toList();

    print(">>>>>>>><<<<<<<<<<<<<<<<<>results>>>>>>>>>>>><<<<<<<<<<<<<${results.length}") ;

    for (var item in results) {
      item["time"] = "";
      item["distance"] = "";

      if (map["latitude"] != "") {
        double distance = calculateHaversineDistance(
            map["latitude"],
            map["longitude"],
            item["location"]["coordinates"][1],
            item["location"]["coordinates"][0]);
        double distanceInKm = distance / 1000;
        double roundedDistance = double.parse(distanceInKm.toStringAsFixed(1));
        double travelTimeInSeconds =
            estimateTravelTime(distance, 60); // Assuming 60 km/h average speed
        double travelTimeInMinutes = (travelTimeInSeconds / 60).roundToDouble();
        item["time"] = "$travelTimeInMinutes min";
        item["distance"] = "${roundedDistance} km";
      }
    }

    return ResponseModel(message: "", status: true, data: results);
  }

  @override
  Future<ResponseModel> createPropertyApi(Map<String, dynamic> map) async {
    ResponseModel responseModel =
        ResponseModel(data: null, status: false, message: "");
    printLog("addPropertyApi>>>>>>>>>>>>>>>>>>>>>>>>>>>.${map}");

    try {
      final cloudinary = Cloudinary.signedConfig(
        apiKey: cloudinaryApiKey,
        apiSecret: cloudinaryApiSecret,
        cloudName: cloudinaryCloudName,
      );

      var colProperty = AppData.db.collection(tblProperty);
      var colPropertyImages = AppData.db.collection(tblPropertyImages);
      map["created_at"] = DateTime.now();
      var res = await colProperty.insertOne(map);

      List<Map<String, dynamic>> imagesList = [];
      for (ImagesSelectionModel imagesSelectionModel in AppData.imagesList
        ..where((element) => element.file != null)) {
        if (imagesSelectionModel.file != null) {
          XFile file = imagesSelectionModel.file ?? XFile("path");
          final response = await cloudinary.upload(
            file: file.path,
            folder: "PROPERTY",
            resourceType: CloudinaryResourceType.image,
            progressCallback: (count, total) {
              print('Uploading image from file with progress: $count/$total');
            },
          );
          if (response.isSuccessful) {
            print('Get your image from with ${response.secureUrl}');
            imagesList.add(
                {"property_id": res.id, "image_url": "${response.secureUrl}"});
          }
        }
      }
      colPropertyImages.insertMany(imagesList);
    } catch (e, t) {
      print(">>>>>>>>>>>>>>>>>.EXXXXXXX ${e.toString()} $t");
      responseModel.status = false;
      responseModel.message = "$e";
      return responseModel;
    }
    responseModel.status = true;
    responseModel.message = "Added Successfully";
    return responseModel;
  }
}
