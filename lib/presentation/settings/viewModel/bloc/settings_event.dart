part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class FetchVersionData extends SettingsEvent {}
