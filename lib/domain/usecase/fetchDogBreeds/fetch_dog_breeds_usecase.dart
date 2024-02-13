import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dog_api/domain/model/dogBreed/dog_breed_res_model.dart';
import 'package:dog_api/domain/repository/dogBreed/dog_repository.dart';

import '../../../core/network/network_error.dart';

class DogBreedsUseCase {
  IDogBreedRepository? iDogBreedRepository;
  DogBreedsUseCase({required this.iDogBreedRepository});

  Future<Either<Failure, DogBreedsResponseModel?>>? fetchDogBreeds({String? breedName}) async {
    try {
      DogBreedsResponseModel? dogs = await iDogBreedRepository?.fetchDogBreeds(breedName: breedName);
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
