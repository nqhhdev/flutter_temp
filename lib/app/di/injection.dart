part of app_layer;

GetIt getIt = GetIt.instance;

Future setupInjection() async {
  await _registerAppComponents();
  await _registerNetworkComponents();
}

Future _registerAppComponents() async {
  final sharedPreferencesManager = await SharedPreferencesManager.getInstance();
  getIt.registerSingleton<SharedPreferencesManager>(sharedPreferencesManager!);

  final appTheme = ThemeManager();
  getIt.registerSingleton(appTheme);
}

Future<void> _registerNetworkComponents() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: ConfigManager.getInstance()!.apiBaseUrl,
      connectTimeout: 10000,
    ),
  );

  final Alice alice = Alice(
    navigatorKey: NavigationUtil.rootKey,
    showShareButton: false,
  );

  getIt.registerSingleton(alice);

  dio.interceptors.addAll(
    [
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
      alice.getDioInterceptor(),
    ],
  );
  getIt.registerSingleton(dio);
}
