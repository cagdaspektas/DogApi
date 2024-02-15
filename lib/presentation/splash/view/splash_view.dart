import 'package:dog_api/core/init/constants/image_constants.dart';
import 'package:dog_api/presentation/home/view/home_view.dart';
import 'package:dog_api/presentation/splash/viewModel/bloc/splash_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kartal/kartal.dart';

import '../../../data/di/dependency_injection.dart';
import '../../main/view/main_view.dart';

@immutable
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = di<SplashBloc>();
    return Material(
        child: BlocListener<SplashBloc, SplashState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.splashStateStatus == SplashStateStatus.completed) {
          FlutterNativeSplash.remove();
          bloc.close();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        }
      },
      child: BlocBuilder<SplashBloc, SplashState>(
        bloc: bloc,
        builder: (context, state) {
          switch (state.splashStateStatus) {
            case SplashStateStatus.initial:
              bloc.add(FetchDogs());
              return Center(
                child: Image.asset(
                  Assets.splashLogo,
                  scale: 3,
                ),
              );
            case SplashStateStatus.loading:
              return Center(
                child: Image.asset(
                  Assets.splashLogo,
                  scale: 3,
                ),
              );
            case SplashStateStatus.getFirstData:
              bloc.add(FetchDogBreed());

              return Center(
                child: Image.asset(
                  Assets.splashLogo,
                  scale: 3,
                ),
              );

            case SplashStateStatus.getSecondData:
              return Center(
                child: Image.asset(
                  Assets.splashLogo,
                  scale: 3,
                ),
              );
            case SplashStateStatus.error:
              return Center(
                child: Text(
                  state.failure?.errorMessage ?? "",
                  style: context.textTheme.bodyLarge,
                ),
              );
            case SplashStateStatus.completed:
            default:
              return const Text("veri yok");
          }
        },
      ),
    ));
  }
}
