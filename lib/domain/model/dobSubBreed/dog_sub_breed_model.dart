// To parse this JSON data, do
//
//     final dogSubBreedModel = dogSubBreedModelFromJson(jsonString);

import 'package:dog_api/domain/model/base_model.dart';

class DogSubBreedModel extends BaseModel {
  List<String>? message;
  String? status;

  DogSubBreedModel({
    this.message,
    this.status,
  });

  factory DogSubBreedModel.fromJson(Map<String, dynamic> json) => DogSubBreedModel(
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
    return DogSubBreedModel(
      message: List<String>.from(json["message"].map((x) => x)),
      status: json["status"],
    );
  }
}
