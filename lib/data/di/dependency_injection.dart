import 'package:dog_api/presentation/splash/viewModel/bloc/splash_screen_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../core/network/network_manager.dart';
import '../../domain/usecase/fetchDogBreeds/fetch_dog_breeds_usecase.dart';
import '../../domain/usecase/getDogs/get_dogs_usecase.dart';
import '../../presentation/home/viewmodel/home_bloc.dart';
import '../repository/dog/dog_repository_imp.dart';
import '../repository/dogBreeds/dog_breeds_repository_impl.dart';
import '../repository/repository_manager.dart';

final di = GetIt.instance;

Future<void> setupDi() async {
  //Network - Service
  di.registerLazySingleton<Dio>(() => NetworkManager.instance.dio);
  di.registerLazySingleton<RepositoryManager>(() => RepositoryManager(dio: di<Dio>()));
  di.registerLazySingleton<DogRepositoryImpl>(() => DogRepositoryImpl(repositoryManager: di<RepositoryManager>()));
  di.registerLazySingleton<DogBreedsRepositoryImpl>(
      () => DogBreedsRepositoryImpl(repositoryManager: di<RepositoryManager>()));

  //Usecase
  di.registerFactory<GetDogUseCase>(() => GetDogUseCase(iDogRepository: di<DogRepositoryImpl>()));
  di.registerFactory<DogBreedsUseCase>(() => DogBreedsUseCase(iDogBreedRepository: di<DogBreedsRepositoryImpl>()));

  //Viewmodel - Bloc
  di.registerFactory<HomeBloc>(() => HomeBloc(getCarsUseCase: di<GetDogUseCase>()));
  di.registerFactory<SplashBloc>(
      () => SplashBloc(getDogsUseCase: di<GetDogUseCase>(), fetchDogBreed: di<DogBreedsUseCase>()));
}
