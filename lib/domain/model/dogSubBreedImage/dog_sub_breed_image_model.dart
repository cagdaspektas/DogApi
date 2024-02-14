// To parse this JSON data, do
//
//     final dogSubBreedImageModel = dogSubBreedImageModelFromJson(jsonString);

import 'package:dog_api/domain/model/base_model.dart';

class DogSubBreedImageModel extends BaseModel {
  List<String>? message;
  String? status;

  DogSubBreedImageModel({
    this.message,
    this.status,
  });

  factory DogSubBreedImageModel.fromJson(Map<String, dynamic> json) => DogSubBreedImageModel(
        message: List<String>.from(json["message"].map((x) => x)),
        status: json["status"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message?.map((x) => x) ?? []),
        "status": status,
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return DogSubBreedImageModel(
      message: List<String>.from(json["message"].map((x) => x)),
      status: json["status"],
    );
  }
}
