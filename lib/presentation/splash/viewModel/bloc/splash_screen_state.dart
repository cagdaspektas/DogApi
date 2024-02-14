part of 'splash_screen_bloc.dart';

enum SplashStateStatus { initial, loading, getFirstData, getSecondData, error, completed }

class SplashState {
  SplashStateStatus? splashStateStatus;
  Failure? failure;
  DogResponseModel? dogsModel;
  DogBreedsResponseModel? dogBreedsResponseModel;

  SplashState(
      {this.splashStateStatus = SplashStateStatus.initial, this.dogsModel, this.dogBreedsResponseModel, this.failure});

  SplashState copyWith({
    SplashStateStatus? splashStateStatus,
    Failure? failure,
    DogResponseModel? dogsModel,
    DogBreedsResponseModel? dogBreedsResponseModel,
  }) {
    return SplashState(
        splashStateStatus: splashStateStatus ?? this.splashStateStatus,
        dogBreedsResponseModel: dogBreedsResponseModel ?? this.dogBreedsResponseModel,
        failure: failure ?? this.failure,
        dogsModel: dogsModel ?? this.dogsModel);
  }
}
