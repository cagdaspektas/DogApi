class DogListModel {
  String? breedName;
  String? breedImage;

  DogListModel({this.breedName, this.breedImage});

  factory DogListModel.fromJson(Map<String, dynamic> json) =>
      DogListModel(breedName: json["breedName"], breedImage: json["breedImage"]);
}
