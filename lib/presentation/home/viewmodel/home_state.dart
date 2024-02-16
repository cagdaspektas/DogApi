part of 'home_bloc.dart';

enum HomeStateStatus { initial, loading, error, onTap, searh, onGenerate, completed }

class HomeState {
  HomeStateStatus? homeStateStatus;
  Failure? failure;
  List<DogListModel>? dogList;
  DogSubBreedModel? dogSubBreedModel;
  FetchSubBreedImageData? fetchSubBreedImageData;
  DogSubBreedImageModel? dogSubBreedImageModel;
  HomeState(
      {this.homeStateStatus = HomeStateStatus.initial,
      this.dogList,
      this.fetchSubBreedImageData,
      this.dogSubBreedImageModel,
      this.dogSubBreedModel,
      this.failure});

  HomeState copyWith(
      {HomeStateStatus? homeStateStatus,
      Failure? failure,
      DogSubBreedModel? dogSubBreedModel,
      DogSubBreedImageModel? dogSubBreedImageModel,
      FetchSubBreedImageData? fetchSubBreedImageData,
      List<DogListModel>? dogList}) {
    return HomeState(
        dogSubBreedModel: dogSubBreedModel ?? this.dogSubBreedModel,
        dogSubBreedImageModel: dogSubBreedImageModel ?? this.dogSubBreedImageModel,
        fetchSubBreedImageData: fetchSubBreedImageData ?? this.fetchSubBreedImageData,
        homeStateStatus: homeStateStatus ?? this.homeStateStatus,
        failure: failure ?? this.failure,
        dogList: dogList ?? this.dogList);
  }
}
