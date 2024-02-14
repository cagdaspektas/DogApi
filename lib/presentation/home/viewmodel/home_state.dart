part of 'home_bloc.dart';

enum HomeStateStatus { initial, loading, error, completed }

class HomeState {
  HomeStateStatus? homeStateStatus;
  Failure? failure;
  List<DogListModel>? dogList;
  HomeState({this.homeStateStatus = HomeStateStatus.initial, this.dogList, this.failure});

  HomeState copyWith({HomeStateStatus? homeStateStatus, Failure? failure, List<DogListModel>? dogList}) {
    return HomeState(
        homeStateStatus: homeStateStatus ?? this.homeStateStatus,
        failure: failure ?? this.failure,
        dogList: dogList ?? this.dogList);
  }
}
