import 'dart:developer';

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
      Either<Failure, DogResponseModel?>? response = await getDogsUseCase.getDogs();
      response?.fold((l) {
        emit(state.copyWith(
            splashStateStatus: SplashStateStatus.error, dogsModel: null, dogBreedsResponseModel: null, failure: l));
      }, (r) async {
        dogsModel = r;
      });
      emit(state.copyWith(
          splashStateStatus: SplashStateStatus.getFirstData,
          dogsModel: dogsModel,
          dogBreedsResponseModel: dogBreedsResponseModel,
          failure: null));
    });
    on<FetchDogBreed>((event, emit) async {
      /*  Either<Failure, DogBreedsResponseModel?>? response;
      emit(state.copyWith(splashStateStatus: SplashStateStatus.getSecondData));
      Hive.registerAdapter(DogListModelAdapter());
      var box = await Hive.openBox('dogBox');
      dogsModel?.message?.forEach((key, value) async {
        List<String> data = [];
        data = value;
        if (data.isNotEmpty) {
          for (var i = 0; i < data.length; i++) {
            response = await fetchDogBreed.fetchDogBreeds(breedName: '$key/${data[i]}');
          }
        } else {
          response = await fetchDogBreed.fetchDogBreeds(breedName: key);
        }
        response?.fold((l) {
          return;
        }, (r) async {
          dogBreedsResponseModel = r;
          dogsModel?.message?.forEach((key, value) async {
            List<String> data = [];
            data = value;
            if (data.isNotEmpty) {
              for (var i = 0; i < data.length; i++) {
                dogList.add(DogListModel(breedName: '$key/${data[i]}', breedImage: dogBreedsResponseModel?.message));
              }
            } else {
              dogList.add(DogListModel(breedName: key, breedImage: dogBreedsResponseModel?.message));
            }
          });
        });
        await box.addAll(dogList);
        log(dogList[0].breedImage.toString());
      });
      emit(state.copyWith(
          splashStateStatus: SplashStateStatus.completed,
          dogsModel: dogsModel,
          dogBreedsResponseModel: dogBreedsResponseModel,
          failure: null)); */
      Either<Failure, DogBreedsResponseModel?>? response;
      emit(state.copyWith(splashStateStatus: SplashStateStatus.getSecondData));
      dogBox = Hive.box<DogListModel>("dogBox");

      for (final mapEntry in dogsModel!.message!.entries) {
        final key = mapEntry.key;
        final value = mapEntry.value;
        List<String> data = [];
        data = value;
        if (data.isNotEmpty) {
          for (var i = 0; i < data.length; i++) {
            response = await fetchDogBreed.fetchDogBreeds(breedName: '$key/${data[i]}');
            response?.fold((l) {
              return;
            }, (r) async {
              dogBreedsResponseModel = r;
              dogList.add(DogListModel(breedName: '$key ${data[i]}', breedImage: dogBreedsResponseModel?.message));
            });
          }
        } else {
          response = await fetchDogBreed.fetchDogBreeds(breedName: key);
          response?.fold((l) {
            return;
          }, (r) async {
            dogBreedsResponseModel = r;
            dogList.add(DogListModel(breedName: key, breedImage: dogBreedsResponseModel?.message));
          });
        }
      }

      await dogBox?.addAll(dogList);
      log(dogList[0].breedImage.toString());
      emit(state.copyWith(
          splashStateStatus: SplashStateStatus.completed,
          dogsModel: dogsModel,
          dogBreedsResponseModel: dogBreedsResponseModel,
          failure: null));
    });
  }
}
