import 'package:dog_api/data/di/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/model/dogList/dog_list.dart';

class MainFunction {
  static Future<void> setupInitialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DogListModelAdapter());

    await Hive.openBox<DogListModel>('dogBox');
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    widgetsBinding;
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await setupDi();
  }
}
