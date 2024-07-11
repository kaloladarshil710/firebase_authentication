// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
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
    apiKey: 'AIzaSyA-LsAil4g6dMfoKXz3YrsdHTjeR-x82HI',
    appId: '1:1089438636901:web:796941374c577ce455df8c',
    messagingSenderId: '1089438636901',
    projectId: 'fir-2cc5f',
    authDomain: 'fir-2cc5f.firebaseapp.com',
    storageBucket: 'fir-2cc5f.appspot.com',
    measurementId: 'G-DDDHS7RYM9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsONsihG1i44gnJGhV89EtTeMjXeK3MN4',
    appId: '1:1089438636901:android:779580e41837c6e255df8c',
    messagingSenderId: '1089438636901',
    projectId: 'fir-2cc5f',
    storageBucket: 'fir-2cc5f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3dhgd_ToiOmSchGAqunzNkftrMcDBdAE',
    appId: '1:1089438636901:ios:0f12db23d196b16a55df8c',
    messagingSenderId: '1089438636901',
    projectId: 'fir-2cc5f',
    storageBucket: 'fir-2cc5f.appspot.com',
    iosBundleId: 'com.example.firebase',
  );
}
