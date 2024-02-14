import 'dart:ui';

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
    final viewPadding = MediaQuery.viewPaddingOf(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Dog Api",
            style: TextStyle(color: Colors.black),
          ),
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
                  return GridView.builder(
                      itemCount: state.dogList?.length,
                      padding: const EdgeInsets.all(20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            bloc.add(FetchSubBreedData(breedName: state.dogList?[index].breedName?.split(' ')[0]));
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
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
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    child: Image.network(
                                                      state.dogList?[index].breedImage ?? "",
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
                                              style: TextStyle(
                                                  fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.blue),
                                            ),
                                            const Divider(
                                              thickness: 2.0,
                                              color: Color(0xffF2F2F7),
                                            ),
                                            Text(
                                              state.dogList?[index].breedName ?? "",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(color: Colors.black, fontSize: 18),
                                            ),
                                            SizedBox(height: 1.h),
                                            const Text(
                                              'SubBreed',
                                              style: TextStyle(
                                                  fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.blue),
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
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(12))),
                                                  onPressed: () {},
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
                                });
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
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
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
                                              style: const TextStyle(
                                                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  /*  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: const BoxDecoration(
                                      //you can get rid of below line also
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      //below line is for rectangular shape
                          
                                      //you can change opacity with color here(I used black) for rect
                                      color: Color(0xffADADAD),
                                      //I added some shadow, but you can remove boxShadow also.
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 1.0,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      state.dogList?[index].breedName ?? "",
                                      style: const TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ) */
                                ],
                              ),
                            ],
                          ),
                        );
                      });

                default:
                  return const Text("veri yok");
              }
            },
          ),
        ));
  }
}
