// To parse this JSON data, do
//
//     final dogBreedsResponseModel = dogBreedsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:dog_api/domain/model/base_model.dart';

DogBreedsResponseModel dogBreedsResponseModelFromJson(String str) => DogBreedsResponseModel.fromJson(json.decode(str));

String dogBreedsResponseModelToJson(DogBreedsResponseModel data) => json.encode(data.toJson());

class DogBreedsResponseModel extends BaseModel {
  String? message;

  DogBreedsResponseModel({
    this.message,
  });

  factory DogBreedsResponseModel.fromJson(Map<String, dynamic> json) => DogBreedsResponseModel(
        message: json["message"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "message": message,
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return DogBreedsResponseModel(
      message: json["message"],
    );
  }
}
