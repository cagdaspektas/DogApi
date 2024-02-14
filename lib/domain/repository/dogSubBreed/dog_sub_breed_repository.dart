import 'package:dog_api/domain/model/dobSubBreed/dog_sub_breed_model.dart';

abstract class IDogSubBreedRepository {
  Future<DogSubBreedModel?> fetchDogSubBreeds({String? breedName});
}
