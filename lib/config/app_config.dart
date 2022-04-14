enum AppFlavor {
  development,
  staging,
  production,
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
    appFlavor: AppFlavor.development,
  );

  static AppConfig stagingConfig = AppConfig(
    ///You can fill URL API
    apiBaseUrl: '',
    appFlavor: AppFlavor.staging,
  );

  static AppConfig productionConfig = AppConfig(
    ///You can fill URL API
    apiBaseUrl: '',
    appFlavor: AppFlavor.production,
  );

  static AppConfig? getInstance({flavorName}) {
    if (_instance == null) {
      switch (flavorName) {
        case 'development':
          {
            _instance = devConfig;
          }
          break;
        case 'staging':
          {
            _instance = stagingConfig;
          }
          break;
        case 'production':
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
