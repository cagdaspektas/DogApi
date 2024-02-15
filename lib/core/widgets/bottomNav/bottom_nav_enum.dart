import 'package:dog_api/core/init/constants/image_constants.dart';
import 'package:dog_api/presentation/home/view/home_view.dart';
import 'package:dog_api/presentation/settings/view/settings_view.dart';
import 'package:flutter/material.dart';

enum NavItem {
  home(Assets.homeNav, HomeView.new),
  settings(Assets.settingsNav, SettingsView.new),
  ;

  const NavItem(this.navIconAsset, this.builder);

  final String navIconAsset;
  final Widget Function() builder;
}
