part of 'home_bloc.dart';

abstract class HomeEvent {}

class FetchData extends HomeEvent {}

class FetchSubBreedData extends HomeEvent {
  String? breedName;
  String? image;
  String? fullName;
  FetchSubBreedData({this.breedName, this.fullName, this.image});
}

class FetchSubBreedImageData extends HomeEvent {
  String? breedName;

  FetchSubBreedImageData({
    this.breedName,
  });
}
