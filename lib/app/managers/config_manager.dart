part of app_layer;

enum FlavorManager {
  dev,
  stag,
  prod,
}

class ConfigManager {
  final String apiBaseUrl;
  final FlavorManager appFlavor;

  ConfigManager({
    required this.apiBaseUrl,
    required this.appFlavor,
  });

  static ConfigManager? _instance;

  static ConfigManager devConfig = ConfigManager(
    ///You can fill URL API
    apiBaseUrl: '',
    appFlavor: FlavorManager.dev,
  );

  static ConfigManager stagingConfig = ConfigManager(
    ///You can fill URL API
    apiBaseUrl: '',
    appFlavor: FlavorManager.stag,
  );

  static ConfigManager productionConfig = ConfigManager(
    ///You can fill URL API
    apiBaseUrl: '',
    appFlavor: FlavorManager.prod,
  );

  FirebaseOptions get flavorFirebaseOption {
    switch (_instance?.appFlavor) {
      case FlavorManager.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
      case FlavorManager.stag:
        return staging.DefaultFirebaseOptions.currentPlatform;
      case FlavorManager.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
      default:
        return dev.DefaultFirebaseOptions.currentPlatform;
    }
  }

  static ConfigManager? getInstance({flavorName}) {
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
