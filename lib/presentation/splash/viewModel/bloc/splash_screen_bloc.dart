import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dog_api/domain/model/dogBreed/dog_breed_res_model.dart';
import 'package:dog_api/domain/model/dogList/dog_list.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/network_error.dart';
import '../../../../domain/model/dogs/dog_model.dart';
import '../../../../domain/usecase/fetchDogBreeds/fetch_dog_breeds_usecase.dart';
import '../../../../domain/usecase/getDogs/get_dogs_usecase.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  GetDogUseCase getDogsUseCase;
  DogBreedsUseCase fetchDogBreed;
  DogListModel? dogListModel;
  DogBreedsResponseModel? dogBreedsResponseModel;
  DogResponseModel? dogsModel;

  Future<DogBreedsResponseModel?>? _fetchDogBreedImages() async {
    Either<Failure, DogBreedsResponseModel?>? response;

    dogsModel?.message?.forEach((key, value) async {
      List<String> data = [];
      data = value;
      if (data.isNotEmpty) {
        for (var i = 0; i < data.length; i++) {
          response = value.isNotEmpty
              ? await fetchDogBreed.fetchDogBreeds(breedName: '$key/${data[i]}')
              : await fetchDogBreed.fetchDogBreeds(breedName: key);
        }
      }
    });
    response?.fold((l) {
      return;
    }, (r) {
      dogBreedsResponseModel = r;
    });
    return dogBreedsResponseModel;
  }

  SplashBloc({required this.getDogsUseCase, required this.fetchDogBreed}) : super(SplashState()) {
    on<FetchDogs>((event, emit) async {
      emit(state.copyWith(splashStateStatus: SplashStateStatus.loading));
      Either<Failure, DogResponseModel?>? response = await getDogsUseCase.getDogs();
      response?.fold((l) {
        emit(state.copyWith(
            splashStateStatus: SplashStateStatus.error, dogsModel: null, dogBreedsResponseModel: null, failure: l));
      }, (r) {
        dogsModel = r;
      });
      await _fetchDogBreedImages();
      emit(state.copyWith(
          splashStateStatus: SplashStateStatus.completed,
          dogsModel: dogsModel,
          dogBreedsResponseModel: dogBreedsResponseModel,
          failure: null));
    });
  }
}
