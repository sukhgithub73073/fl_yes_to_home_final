// To parse this JSON data, do
//
//     final propertyModel = propertyModelFromJson(jsonString);

import 'dart:convert';

PropertyModel propertyModelFromJson(String str) =>
    PropertyModel.fromJson(json.decode(str));

String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());

class PropertyModel {
  List<Datum> data;

  PropertyModel({
    required this.data,
  });

  PropertyModel copyWith({
    List<Datum>? data,
  }) =>
      PropertyModel(
        data: data ?? this.data,
      );

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic id;
  dynamic vendor_id;
  String title;
  String description;
  String type;
  String area;
  String price;
  String address;
  Location location;
  OnwerDetail onwerDetail;
  String furnishing;
  String bedrooms;
  String bathrooms;
  String parking;
  List<ImagesList> imagesList;
  String time;

  String distance;

  Datum({
    required this.id,
    required this.vendor_id,
    required this.title,
    required this.description,
    required this.type,
    required this.area,
    required this.price,
    required this.address,
    required this.location,
    required this.onwerDetail,
    required this.furnishing,
    required this.bedrooms,
    required this.bathrooms,
    required this.parking,
    required this.imagesList,
    required this.time,
    required this.distance,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        vendor_id: json["vendor_id"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        area: json["area"]??"",
        price: json["price"],
        address: json["address"]??"",
        location: Location.fromJson(json["location"]),
        onwerDetail: OnwerDetail.fromJson(json["onwerDetail"]??{}),
        furnishing: json["furnishing"],
        bedrooms: json["bedrooms"],
        bathrooms: json["bathrooms"],
        parking: json["parking"],
        time: json["time"],
        distance: json["distance"],
        imagesList: List<ImagesList>.from(
            json["imagesList"].map((x) => ImagesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor_id": vendor_id,
        "title": title,
        "description": description,
        "type": type,
        "area": area,
        "price": price,
        "address": address,
        "location": location.toJson(),
        "onwerDetail": onwerDetail.toJson(),
        "furnishing": furnishing,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "parking": parking,
        "time": time,
        "distance": distance,
        "imagesList": List<dynamic>.from(imagesList.map((x) => x.toJson())),
      };
}

class OnwerDetail {
  String name;
  String mobile;
  String veg_status;

  String time_status;

  String visitor_status;

  String guardian_status;

  String drinking_status;

  OnwerDetail(
      {required this.name,
      required this.mobile,
      required this.veg_status,
      required this.time_status,
      required this.visitor_status,
      required this.guardian_status,
      required this.drinking_status});

  factory OnwerDetail.fromJson(Map<String, dynamic> json) => OnwerDetail(
        name: json["name"] ?? "",
        mobile: json["mobile"] ?? "",
        veg_status: json["veg_status"] ?? "",
        time_status: json["time_status"] ?? "",
        visitor_status: json["visitor_status"] ?? "",
        guardian_status: json["guardian_status"] ?? "",
        drinking_status: json["drinking_status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        // "type": type,
        "name": name,
        "mobile": mobile,
        "veg_status": veg_status,
        "time_status": time_status,
        "visitor_status": visitor_status,
        "guardian_status": guardian_status,
        "drinking_status": drinking_status
      };
}

class Location {
  String type;
  List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class ImagesList {
  String image_url;

  ImagesList({
    required this.image_url,
  });

  factory ImagesList.fromJson(Map<String, dynamic> json) => ImagesList(
        image_url: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": image_url,
      };
}
