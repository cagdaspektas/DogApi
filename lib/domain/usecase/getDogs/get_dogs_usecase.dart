import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../core/network/network_error.dart';
import '../../model/dogs/dog_model.dart';
import '../../repository/dog/DOG_repository.dart';

class GetDogUseCase {
  GetDogUseCase({required this.iDogRepository});
  IDogRepository iDogRepository;

  Future<Either<Failure, DogResponseModel?>?> getDogs() async {
    try {
      DogResponseModel? dogs = await iDogRepository.getDogs();
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
