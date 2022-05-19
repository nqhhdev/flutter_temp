import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_temp_by_nqh/firebase/firebase_options.dart' as prod;
import 'package:flutter_temp_by_nqh/firebase/firebase_options_dev.dart' as dev;
import 'package:flutter_temp_by_nqh/firebase/firebase_options_staging.dart' as staging;

enum AppFlavor {
  dev,
  stag,
  prod,
}

class AppConfig {
  final String apiBaseUrl;
  final AppFlavor appFlavor;

  AppConfig({
    required this.apiBaseUrl,
    required this.appFlavor,
  });

  static AppConfig? _instance;

  static AppConfig devConfig = AppConfig(
    ///You can fill URL API
    apiBaseUrl: '',
    appFlavor: AppFlavor.dev,
  );

  static AppConfig stagingConfig = AppConfig(
    ///You can fill URL API
    apiBaseUrl: '',
    appFlavor: AppFlavor.stag,
  );

  static AppConfig productionConfig = AppConfig(
    ///You can fill URL API
    apiBaseUrl: '',
    appFlavor: AppFlavor.prod,
  );

  FirebaseOptions get flavorFirebaseOption {
    switch (_instance?.appFlavor) {
      case AppFlavor.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
      case AppFlavor.stag:
        return staging.DefaultFirebaseOptions.currentPlatform;
      case AppFlavor.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
      default:
        return dev.DefaultFirebaseOptions.currentPlatform;
    }
  }

  static AppConfig? getInstance({flavorName}) {
    if (_instance == null) {
      switch (flavorName) {
        case 'dev':
          {
            _instance = devConfig;
          }
          break;
        case 'stag':
          {
            _instance = stagingConfig;
          }
          break;
        case 'prod':
          {
            _instance = productionConfig;
          }
          break;
      }
      return _instance;
    }
    return _instance;
  }
}
