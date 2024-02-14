part of 'home_bloc.dart';

abstract class HomeEvent {}

class FetchData extends HomeEvent {}

class FetchSubBreedData extends HomeEvent {
  String? breedName;
  FetchSubBreedData({this.breedName});
}

class FetchSubBreedImageData extends HomeEvent {
  String? breedName;
  FetchSubBreedImageData({this.breedName});
}
