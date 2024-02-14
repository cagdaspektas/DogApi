import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dog_api/core/network/network_error.dart';

import '../../model/dobSubBreed/dog_sub_breed_model.dart';
import '../../repository/dogSubBreed/dog_sub_breed_repository.dart';

class DogSubBreedsUseCase {
  IDogSubBreedRepository? iDogBreedRepository;
  DogSubBreedsUseCase({required this.iDogBreedRepository});

  Future<Either<Failure, DogSubBreedModel?>>? fetchDogSubBreeds({String? breedName}) async {
    try {
      DogSubBreedModel? dogs = await iDogBreedRepository?.fetchDogSubBreeds(breedName: breedName);
      return Right(dogs);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return Left(Failure(errorMessage: e.message, statusCode: e.response?.statusCode));
      } else {
        return Left(Failure(errorMessage: e.message, statusCode: e.response?.statusCode));
      }
    }
  }
}
