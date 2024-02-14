import 'package:dog_api/core/init/constants/app_constants.dart';
import 'package:dog_api/core/init/constants/string_constants.dart';
import 'package:dog_api/presentation/splash/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

import 'core/init/theme/app_theme.dart';

import 'data/di/dependency_injection.dart';
import 'domain/model/dogList/dog_list.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DogListModelAdapter());

  await Hive.openBox<DogListModel>('dogBox');
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  widgetsBinding;
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setupDi();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: ApplicationConstants.debugMode,
        theme: ThemeManager.craeteTheme((AppThemeLight())),
        title: StringConstants.instance.appName,
        home: const Directionality(
          textDirection: TextDirection.ltr,
          child: SplashScreen(),
        ),
      );
    });
  }
}
