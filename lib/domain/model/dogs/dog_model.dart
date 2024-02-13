// To parse this JSON data, do
//
//     final dogResponseModel = dogResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:dog_api/domain/model/base_model.dart';

DogResponseModel dogResponseModelFromJson(String str) => DogResponseModel.fromJson(json.decode(str));

String dogResponseModelToJson(DogResponseModel data) => json.encode(data.toJson());

class DogResponseModel extends BaseModel {
  Map<String, List<String>>? message;
  String? status;

  DogResponseModel({
    this.message,
    this.status,
  });

  factory DogResponseModel.fromJson(Map<String, dynamic> json) => DogResponseModel(
        message: Map.from(json["message"])
            .map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
        status: json["status"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "message": Map.from(message!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "status": status,
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return DogResponseModel(
      message: Map.from(json["message"])
          .map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
      status: json["status"],
    );
  }
}
