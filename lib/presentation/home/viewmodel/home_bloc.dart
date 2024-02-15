import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dog_api/domain/model/dobSubBreed/dog_sub_breed_model.dart';
import 'package:dog_api/domain/model/dogList/dog_list.dart';
import 'package:dog_api/domain/model/dogSubBreedImage/dog_sub_breed_image_model.dart';
import 'package:dog_api/domain/usecase/fetchDogSubBreedImage/fetch_dog_sub_breed_usecase.dart';
import 'package:dog_api/presentation/splash/viewModel/bloc/splash_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/network/network_error.dart';
import '../../../domain/usecase/fetchDogSubBreeds/fetch_dog_sub_breeds_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Box<DogListModel>? dogBox;
  List<DogListModel> dogList = [];
  DogSubBreedModel? dogSubBreedModel;
  DogSubBreedImageModel? dogSubBreedImageModel;
  DogSubBreedsUseCase dogSubBreedsUseCase;
  DogSubBreedsImageUseCase dogSubBreedsImageUseCase;
  String? image;
  String? fullName;

  HomeBloc({required this.dogSubBreedsUseCase, required this.dogSubBreedsImageUseCase}) : super(HomeState()) {
    on<FetchData>((event, emit) async {
      dogBox = Hive.box<DogListModel>("dogBox");
      dogList = dogBox?.values.toList() ?? [];

      emit(state.copyWith(homeStateStatus: HomeStateStatus.completed, failure: null, dogList: dogList));
    });
    on<FetchSubBreedData>((event, emit) async {
      Either<Failure, DogSubBreedModel?>? response =
          await dogSubBreedsUseCase.fetchDogSubBreeds(breedName: event.breedName);
      response?.fold((l) {
        emit(state.copyWith(homeStateStatus: HomeStateStatus.error, failure: l, dogList: dogList));
      }, (r) async {
        dogSubBreedModel = r;
        image = event.image;
        fullName = event.fullName;
      });

      emit(state.copyWith(
          homeStateStatus: HomeStateStatus.onTap, failure: null, dogList: dogList, dogSubBreedModel: dogSubBreedModel));
    });
    on<FetchSubBreedImageData>((event, emit) async {
      Either<Failure, DogSubBreedImageModel?>? response =
          await dogSubBreedsImageUseCase.fetchDogSubBreedsImage(breedName: event.breedName);
      response?.fold((l) {
        emit(state.copyWith(homeStateStatus: HomeStateStatus.error, failure: l, dogList: dogList));
      }, (r) async {
        dogSubBreedImageModel = r;
      });

      emit(state.copyWith(
          homeStateStatus: HomeStateStatus.completed,
          failure: null,
          dogList: dogList,
          dogSubBreedModel: dogSubBreedModel));
    });
  }
}
