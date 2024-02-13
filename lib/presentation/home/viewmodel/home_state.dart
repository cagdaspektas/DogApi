part of 'home_bloc.dart';

enum HomeStateStatus { initial, loading, error, completed }

class HomeState {
  HomeStateStatus? homeStateStatus;
  Failure? failure;
  DogResponseModel? carsModel;

  HomeState({this.homeStateStatus = HomeStateStatus.initial, this.carsModel, this.failure});

  HomeState copyWith({
    HomeStateStatus? homeStateStatus,
    Failure? failure,
    DogResponseModel? carsModel,
  }) {
    return HomeState(
        homeStateStatus: homeStateStatus ?? this.homeStateStatus,
        failure: failure ?? this.failure,
        carsModel: carsModel ?? this.carsModel);
  }
}
