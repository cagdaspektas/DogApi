import '../../model/dogs/dog_model.dart';

abstract class IDogRepository {
  Future<DogResponseModel?> getDogs();
}
