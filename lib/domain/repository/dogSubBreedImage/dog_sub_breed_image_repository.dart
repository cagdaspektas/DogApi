import 'package:dog_api/domain/model/dogSubBreedImage/dog_sub_breed_image_model.dart';

abstract class IDogSubBreedImageRepository {
  Future<DogSubBreedImageModel?> fetchDogSubImageBreeds({String? breedName});
}
