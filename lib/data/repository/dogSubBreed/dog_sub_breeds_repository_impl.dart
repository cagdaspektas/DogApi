import 'package:dog_api/domain/model/dobSubBreed/dog_sub_breed_model.dart';

import '../../../core/init/enums/service_enum.dart';
import '../../../domain/repository/dogSubBreed/dog_sub_breed_repository.dart';
import '../repository_manager.dart';

class DogSubBreedsRepositoryImpl extends IDogSubBreedRepository {
  RepositoryManager? repositoryManager;
  DogSubBreedsRepositoryImpl({required this.repositoryManager});

  @override
  Future<DogSubBreedModel?> fetchDogSubBreeds({String? breedName}) async {
    DogSubBreedModel? dogSubBreedsRepository = await repositoryManager?.fetch(
        path: ServiceEnum.fetchBreeds.servicePaths(breedName: breedName), model: DogSubBreedModel());
    return dogSubBreedsRepository;
  }
}
