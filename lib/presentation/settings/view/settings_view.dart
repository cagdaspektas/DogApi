import 'package:dog_api/presentation/settings/viewModel/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

import '../../../data/di/dependency_injection.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = di<SettingsBloc>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Dog Api",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocListener<SettingsBloc, SettingsState>(
          bloc: bloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          child: BlocBuilder<SettingsBloc, SettingsState>(
            bloc: bloc,
            builder: (context, state) {
              switch (state.settingsStateStatus) {
                case SettingsStateEnum.initial:
                  bloc.add(FetchVersionData());
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.red,
                  ));
                case SettingsStateEnum.loading:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.red,
                  ));
                case SettingsStateEnum.error:
                  return Center(
                    child: Text(
                      state.failure?.errorMessage ?? "",
                      style: context.textTheme.bodyLarge,
                    ),
                  );
                case SettingsStateEnum.completed:
                  return ListView.builder(
                    itemCount: bloc.profileList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      bloc.profileList[index].icon,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(bloc.profileList[index].textName,
                                        style: const TextStyle(color: Colors.black, fontSize: 16)),
                                  ],
                                ),
                                bloc.profileList[index].textName == "Os Version"
                                    ? Text(
                                        bloc.version ?? "0.0.0",
                                        style: const TextStyle(color: Colors.black, fontSize: 16.0),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                            const Divider(
                              thickness: 4,
                              color: Color(0xffF2F2F7),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                default:
                  return const Text("veri yok");
              }
            },
          ),
        ));
  }
}
