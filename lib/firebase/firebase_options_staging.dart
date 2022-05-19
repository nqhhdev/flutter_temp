// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_staging.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDBviEJexP5cBpawTQpDxnBAti3SLN6cuE',
    appId: '1:425597811061:web:0f762f3d01bc7b9809bb3c',
    messagingSenderId: '425597811061',
    projectId: 'nqh-flutter-temp',
    authDomain: 'nqh-flutter-temp.firebaseapp.com',
    storageBucket: 'nqh-flutter-temp.appspot.com',
    measurementId: 'G-SXV863RH6B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDulbwQvU0FvPvlzotxlorXa0P71xag4m0',
    appId: '1:425597811061:android:faa2b887da1bcd1309bb3c',
    messagingSenderId: '425597811061',
    projectId: 'nqh-flutter-temp',
    storageBucket: 'nqh-flutter-temp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBsLxnBy0EuwE_Csu3qqmtNJO8WuFNA490',
    appId: '1:425597811061:ios:2f7705db3207634909bb3c',
    messagingSenderId: '425597811061',
    projectId: 'nqh-flutter-temp',
    storageBucket: 'nqh-flutter-temp.appspot.com',
    iosClientId: '425597811061-34htmhe8cdj53pelhj24b88b3elo75kf.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterTempByNqh.staging',
  );
}
