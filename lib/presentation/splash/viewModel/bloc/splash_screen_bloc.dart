import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dog_api/domain/model/dogBreed/dog_breed_res_model.dart';
import 'package:dog_api/domain/model/dogList/dog_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
  List<DogListModel> dogList = [];
  Box? dogBox;

  SplashBloc({required this.getDogsUseCase, required this.fetchDogBreed}) : super(SplashState()) {
    on<FetchDogs>((event, emit) async {
      emit(state.copyWith(splashStateStatus: SplashStateStatus.loading));
      dogBox = Hive.box<DogListModel>("dogBox");
      if (dogBox!.isNotEmpty) {
        dogBox?.clear();
      }
      Either<Failure, DogResponseModel?>? response = await getDogsUseCase.getDogs();

      response?.fold((l) {
        emit(state.copyWith(
            splashStateStatus: SplashStateStatus.error, dogsModel: null, dogBreedsResponseModel: null, failure: l));
      }, (r) async {
        dogsModel = r;
        emit(state.copyWith(
            splashStateStatus: SplashStateStatus.getFirstData,
            dogsModel: dogsModel,
            dogBreedsResponseModel: dogBreedsResponseModel,
            failure: null));
      });

      for (var element in dogsModel!.message!.entries) {
        final response = await fetchDogBreed.fetchDogBreeds(breedName: element.key);
        response?.fold((l) {
          return;
        }, (r) async {
          dogBreedsResponseModel = r;
          dogList.add(DogListModel(breedName: element.key, breedImage: dogBreedsResponseModel?.message));
        });
      }

      dogBox!.addAll(dogList);

      emit(state.copyWith(
          splashStateStatus: SplashStateStatus.completed,
          dogsModel: dogsModel,
          dogBreedsResponseModel: dogBreedsResponseModel,
          failure: null));
    });
  }
}
