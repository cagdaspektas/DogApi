import 'package:dog_api/core/init/enums/service_enum.dart';
import 'package:dog_api/domain/repository/dog/DOG_repository.dart';

import '../../../domain/model/dogs/dog_model.dart';
import '../repository_manager.dart';

class DogRepositoryImpl extends IDogRepository {
  RepositoryManager? repositoryManager;
  DogRepositoryImpl({required this.repositoryManager});

  @override
  Future<DogResponseModel?> getDogs() async {
    DogResponseModel? dogs =
        await repositoryManager?.fetch(path: ServiceEnum.listAll.servicePaths(), model: DogResponseModel());
    return dogs;
  }
}
