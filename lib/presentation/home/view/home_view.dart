import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import '../../../data/di/dependency_injection.dart';
import '../viewmodel/home_bloc.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final bloc = di<HomeBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("HomeView"),
        ),
        body: BlocListener<HomeBloc, HomeState>(
          bloc: bloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: bloc,
            builder: (context, state) {
              switch (state.homeStateStatus) {
                case HomeStateStatus.initial:
                  bloc.add(FetchData());
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.red,
                  ));
                case HomeStateStatus.loading:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.red,
                  ));
                case HomeStateStatus.error:
                  return Center(
                    child: Text(
                      state.failure?.errorMessage ?? "",
                      style: context.textTheme.bodyLarge,
                    ),
                  );
                case HomeStateStatus.completed:
                  return Center(
                    child: Text(
                      "",
                      //  state.carsModel?.length.toString() ?? "",
                      style: context.textTheme.bodyLarge,
                    ),
                  );
                default:
                  return const Text("veri yok");
              }
            },
          ),
        ));
  }
}
