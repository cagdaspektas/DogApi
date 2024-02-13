part of 'splash_screen_bloc.dart';

@immutable
sealed class SplashEvent {}

class FetchDogs extends SplashEvent {}

class FetchDogBreed extends SplashEvent {}
