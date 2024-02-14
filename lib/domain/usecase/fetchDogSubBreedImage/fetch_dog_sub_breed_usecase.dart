import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dog_api/domain/model/dogSubBreedImage/dog_sub_breed_image_model.dart';
import 'package:dog_api/domain/repository/dogSubBreedImage/dog_sub_breed_image_repository.dart';

import '../../../core/network/network_error.dart';

class DogSubBreedsImageUseCase {
  IDogSubBreedImageRepository? iDogSubBreedImageRepository;
  DogSubBreedsImageUseCase({required this.iDogSubBreedImageRepository});

  Future<Either<Failure, DogSubBreedImageModel?>>? fetchDogSubBreedsImage({String? breedName}) async {
    try {
      DogSubBreedImageModel? dogs = await iDogSubBreedImageRepository?.fetchDogSubImageBreeds(breedName: breedName);
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
