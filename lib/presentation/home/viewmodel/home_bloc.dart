import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dog_api/domain/model/dogList/dog_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/network/network_error.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Box<DogListModel>? dogBox;
  List<DogListModel> dogList = [];

  HomeBloc() : super(HomeState()) {
    on<FetchData>((event, emit) async {
      dogBox = Hive.box<DogListModel>("dogBox");
      dogList = dogBox?.values.toList() ?? [];

      emit(state.copyWith(homeStateStatus: HomeStateStatus.completed, failure: null, dogList: dogList));
    });
  }
}
