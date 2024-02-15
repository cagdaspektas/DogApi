part of 'settings_bloc.dart';

enum SettingsStateEnum { initial, loading, error, completed }

class SettingsState {
  SettingsStateEnum? settingsStateStatus;
  Failure? failure;
  String? version;
  SettingsState({this.settingsStateStatus = SettingsStateEnum.initial, this.version, this.failure});

  SettingsState copyWith({SettingsStateEnum? settingsStateStatus, Failure? failure, String? version}) {
    return SettingsState(
      version: version ?? this.version,
      settingsStateStatus: settingsStateStatus ?? this.settingsStateStatus,
      failure: failure ?? this.failure,
    );
  }
}
