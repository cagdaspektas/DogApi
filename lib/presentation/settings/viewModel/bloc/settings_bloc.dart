import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/network/network_error.dart';
import '../../../../domain/model/settings/settings_model.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const platform = MethodChannel('versionChannel');
  String? version;
  final List<SettingsModel> profileList = [
    SettingsModel(Icons.info_outline, 'Help'),
    SettingsModel(Icons.star_border, 'Rate Us'),
    SettingsModel(Icons.ios_share, 'Share With Friends'),
    SettingsModel(Icons.description_outlined, 'Terms Of Use'),
    SettingsModel(Icons.privacy_tip_outlined, 'Privacy Policy'),
    SettingsModel(Icons.account_tree_outlined, 'Os Version'),
  ];

  SettingsBloc() : super(SettingsState()) {
    on<FetchVersionData>((event, emit) async {
      emit(state.copyWith(settingsStateStatus: SettingsStateEnum.loading));
      try {
        final String result = await platform.invokeMethod('getVersion');
        version = 'Version: ${result.toString()}';
      } on PlatformException catch (e) {
        version = "Failed to get version: '${e.message}'.";
      }
      emit(state.copyWith(settingsStateStatus: SettingsStateEnum.completed, version: version));
    });
  }
}
