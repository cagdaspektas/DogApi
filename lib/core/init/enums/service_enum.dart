enum ServiceEnum { listAll, fetchBreeds, fetchSubBreeds, fetchSubBreedsImage }

extension ServiceExtension on ServiceEnum {
  String servicePaths({String? breedName}) {
    switch (this) {
      case ServiceEnum.listAll:
        return 'breeds/list/all';
      case ServiceEnum.fetchBreeds:
        return 'breed/$breedName/images/random';
      case ServiceEnum.fetchSubBreeds:
        return 'breed/$breedName/list';
      case ServiceEnum.fetchSubBreedsImage:
        return 'breed/$breedName/images';
    }
  }
}
