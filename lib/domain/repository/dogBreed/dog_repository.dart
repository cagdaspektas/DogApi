import 'package:dog_api/domain/model/dogBreed/dog_breed_res_model.dart';

abstract class IDogBreedRepository {
  Future<DogBreedsResponseModel?> fetchDogBreeds({String? breedName});
}
