import 'package:dog_api/domain/model/dogSubBreedImage/dog_sub_breed_image_model.dart';
import 'package:dog_api/domain/repository/dogSubBreedImage/dog_sub_breed_image_repository.dart';

import '../../../core/init/enums/service_enum.dart';
import '../repository_manager.dart';

class DogSubBreedsImageRepositoryImpl extends IDogSubBreedImageRepository {
  RepositoryManager? repositoryManager;
  DogSubBreedsImageRepositoryImpl({required this.repositoryManager});

  @override
  Future<DogSubBreedImageModel?> fetchDogSubImageBreeds({String? breedName}) async {
    DogSubBreedImageModel? dogSubBreedsRepository = await repositoryManager?.fetch(
        path: ServiceEnum.fetchSubBreedsImage.servicePaths(breedName: breedName), model: DogSubBreedImageModel());
    return dogSubBreedsRepository;
  }
}
