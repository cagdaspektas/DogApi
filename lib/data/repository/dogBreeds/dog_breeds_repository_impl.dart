import 'package:dog_api/core/init/enums/service_enum.dart';
import 'package:dog_api/data/repository/repository_manager.dart';
import 'package:dog_api/domain/model/dogBreed/dog_breed_res_model.dart';
import 'package:dog_api/domain/repository/dogBreed/dog_repository.dart';

class DogBreedsRepositoryImpl extends IDogBreedRepository {
  RepositoryManager? repositoryManager;
  DogBreedsRepositoryImpl({required this.repositoryManager});

  @override
  Future<DogBreedsResponseModel?> fetchDogBreeds({String? breedName}) async {
    DogBreedsResponseModel? dogBreedsRepository = await repositoryManager?.fetch(
        path: ServiceEnum.fetchBreeds.servicePaths(breedName: breedName), model: DogBreedsResponseModel());
    return dogBreedsRepository;
  }
}
