import 'dart:ui';

import 'package:dog_api/core/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';
import '../../../data/di/dependency_injection.dart';
import '../viewmodel/home_bloc.dart';

@immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});
  final bloc = di<HomeBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Appbar(),
        ),
        body: BlocListener<HomeBloc, HomeState>(
          bloc: bloc,
          listener: (context, state) {
            if (state.homeStateStatus == HomeStateStatus.onTap) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _firstDialog(context, state);
                  });
            } else if (state.homeStateStatus == HomeStateStatus.onGenerate) {
              showDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return _secondDialog(context);
                  });
            }
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
                case HomeStateStatus.onGenerate:
                case HomeStateStatus.onTap:
                case HomeStateStatus.searh:
                case HomeStateStatus.completed:
                  return Stack(
                    children: [
                      bloc.textEditingController.text.isNotEmpty ? _searchGrid() : _normalGrid(state),
                      DraggableTextFormField(bloc: bloc),
                    ],
                  );

                default:
                  return const Text("veri yok");
              }
            },
          ),
        ));
  }

  GridView _normalGrid(HomeState state) {
    return GridView.builder(
        itemCount: state.dogList?.length,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              bloc.add(FetchSubBreedData(
                breedName: state.dogList?[index].breedName?.split(' ')[0],
                image: state.dogList?[index].breedImage ?? "",
                fullName: state.dogList?[index].breedName ?? "",
              ));
            },
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.network(state.dogList?[index].breedImage ?? "", fit: BoxFit.fill),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.only(bottomLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                      child: Container(
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        child: Stack(
                          children: [
                            //Blur Effect
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                              child: Container(),
                            ),
                            //Gradient Effect

                            //Child
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                              child: Text(
                                state.dogList?[index].breedName ?? "",
                                style:
                                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  GridView _searchGrid() {
    return GridView.builder(
        itemCount: bloc.searchBreeds.length,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              bloc.add(FetchSubBreedData(
                breedName: bloc.searchBreeds[index].breedName?.split(' ')[0],
                image: bloc.searchBreeds[index].breedImage ?? "",
                fullName: bloc.searchBreeds[index].breedName ?? "",
              ));
            },
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.network(bloc.searchBreeds[index].breedImage ?? "", fit: BoxFit.fill),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.only(bottomLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                      child: Container(
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        child: Stack(
                          children: [
                            //Blur Effect
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                              child: Container(),
                            ),
                            //Gradient Effect

                            //Child
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                              child: Text(
                                bloc.searchBreeds[index].breedName ?? "",
                                style:
                                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Padding _secondDialog(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dialog(
        backgroundColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30.h,
                width: 60.w,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      bloc.dogBreedsResponseModel?.message ?? "",
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                height: 1.h,
              ),
              InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(color: Colors.white, child: const Icon(Icons.close, color: Colors.black)))
            ],
          ),
        ),
      ),
    );
  }

  Padding _firstDialog(BuildContext context, HomeState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(children: [
                SizedBox(
                  width: 100.w,
                  height: 50.h,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      child: Image.network(
                        bloc.image ?? "",
                        fit: BoxFit.cover,
                      )),
                ),
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 1.h),
              const Text(
                'Breed',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const Divider(
                thickness: 2.0,
                color: Color(0xffF2F2F7),
              ),
              Text(
                bloc.fullName ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(height: 1.h),
              const Text(
                'SubBreed',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const Divider(
                thickness: 2.0,
                color: Color(0xffF2F2F7),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.dogSubBreedModel?.message?.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Text(
                      state.dogSubBreedModel?.message?[i] ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 80.w,
                height: 7.h,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      bloc.add(FetchBreedGenerateImage(breedName: "${bloc.fullName?.split(" ")[0]}"));
                    },
                    child: const Text(
                      "Generate",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
    );
  }
}

class DraggableTextFormField extends StatelessWidget {
  const DraggableTextFormField({
    super.key,
    required this.bloc,
  });

  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.15,
      minChildSize: 0.1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            controller: scrollController,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(children: [
                  Divider(
                    indent: 40.w,
                    endIndent: 40.w,
                    color: const Color(0xffE5E5EA),
                    thickness: 5,
                  ),
                  TextField(
                    controller: bloc.textEditingController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Search',
                    ),
                    onChanged: (value) {
                      bloc.searchBreeds.clear();
                      bloc.add(SearhcBreeds(breedName: value));
                    },
                  ),
                ]),
              );
            },
          ),
        );
      },
    );
  }
}

class Appbar extends StatelessWidget {
  const Appbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      hasBack: false,
      center: true,
      title: "Dog Api",
      actions: const [],
      appBarOnPressed: () {},
    );
  }
}
