import 'dart:developer';

import 'package:alice/alice.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
  await _flavor;

  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: AppConfig.getInstance()!.flavorFirebaseOption,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await setupInjection();
}

Future<void> get _flavor async {
  await const MethodChannel('flavor').invokeMethod<String>('getFlavor').then(
    (String? flavor) async {
      final appConfig = AppConfig.getInstance(flavorName: flavor);
      log("App Config : ${appConfig!.apiBaseUrl}");
    },
  ).catchError(
    (error) {
      log("Error when set up enviroment: $error");
      AppConfig.getInstance(flavorName: AppFlavor.dev.name);
    },
  );
}

class MyApp extends StatefulWidget {
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  const MyApp({Key? key}) : super(key: key);

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
      builder: (_, __) => MaterialApp(
        builder: (context, child) {
          return child ?? const SizedBox();
        },
        title: 'FTBNqh',
        navigatorObservers: <NavigatorObserver>[MyApp.observer],
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
