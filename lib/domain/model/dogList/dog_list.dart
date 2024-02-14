import 'package:hive/hive.dart';
part 'dog_list.g.dart';

@HiveType(typeId: 0)
class DogListModel {
  @HiveField(0)
  String? breedName;
  @HiveField(1)
  String? breedImage;

  DogListModel({this.breedName, this.breedImage});

  factory DogListModel.fromJson(Map<String, dynamic> json) =>
      DogListModel(breedName: json["breedName"], breedImage: json["breedImage"]);
}
