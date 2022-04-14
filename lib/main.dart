import 'dart:developer';

import 'package:alice/alice.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_temp_by_nqh/config/theme.dart';
import 'package:flutter_temp_by_nqh/utils/di/injection.dart';
import 'package:flutter_temp_by_nqh/utils/route/app_routing.dart';

import 'config/app_config.dart';

Future<void> main() async {
  await _beforeRunApp();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      fallbackLocale: const Locale('en', 'US'),
      path: 'resources/langs/langs.csv',
      assetLoader: CsvAssetLoader(),
      child: const MyApp(),
    ),
  );
}

Future<void> _beforeRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await Firebase.initializeApp();
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // Listen for flavor triggered by iOS / android build
  await const MethodChannel('flavor').invokeMethod<String>('getFlavor').then(
    (String? flavor) async {
      final appConfig = AppConfig.getInstance(flavorName: flavor);
      log("App Config : ${appConfig!.apiBaseUrl}");
    },
  ).catchError(
    (error) {
      AppConfig.getInstance(flavorName: "development");

      log("Error when set up enviroment $error");
    },
  );

  await setupInjection();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  // static FirebaseAnalyticsObserver observer =
  //     FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTheme appTheme = getIt<AppTheme>();

  @override
  void initState() {
    appTheme.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    appTheme.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 800),
      builder: (_) => MaterialApp(
        builder: (context, child) {
          ScreenUtil.setContext(context);
          return child ?? const SizedBox();
        },
        title: 'FTBNqh',
        // navigatorObservers: <NavigatorObserver>[MyApp.observer],
        navigatorKey: getIt<Alice>().getNavigatorKey(),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteDefine.splashScreen.name,
        onGenerateRoute: AppRouting.generateRoute,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appTheme.currentTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
