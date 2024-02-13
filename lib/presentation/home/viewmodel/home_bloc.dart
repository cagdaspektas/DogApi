import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/network/network_error.dart';
import '../../../domain/model/dogs/dog_model.dart';
import '../../../domain/usecase/getDogs/get_dogs_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GetDogUseCase getCarsUseCase;
  DogResponseModel? carsModel;
  HomeBloc({required this.getCarsUseCase}) : super(HomeState()) {
    on<FetchData>((event, emit) async {
      /*   emit(state.copyWith(homeStateStatus: HomeStateStatus.loading));
      Either<Failure, DogResponseModel?>? response = await getCarsUseCase.getCars();
      response.fold((l) {
        emit(state.copyWith(homeStateStatus: HomeStateStatus.error, carsModel: null, failure: l));
      }, (r) {
        carsModel = r;
        emit(state.copyWith(homeStateStatus: HomeStateStatus.completed, carsModel: carsModel, failure: null));
      }); */
    });
  }
}
