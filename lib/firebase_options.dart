// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
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
    apiKey: 'AIzaSyAQu00LFYO4M9o48r6elhYGWo4QJJT5qYI',
    appId: '1:796639206941:web:1b39a4eb444ece43ebf0f4',
    messagingSenderId: '796639206941',
    projectId: 'happy-caretakers',
    authDomain: 'happy-caretakers.firebaseapp.com',
    storageBucket: 'happy-caretakers.appspot.com',
    measurementId: 'G-5VS40HHTF7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPZ-u2l6vjPTe5bQvRE7aX3kBrZ4swrm8',
    appId: '1:796639206941:android:8d199a7a2bd9f640ebf0f4',
    messagingSenderId: '796639206941',
    projectId: 'happy-caretakers',
    storageBucket: 'happy-caretakers.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGZS42tTbVVYrqo2atXHAx6DRKskPClLA',
    appId: '1:796639206941:ios:c171576d677c7371ebf0f4',
    messagingSenderId: '796639206941',
    projectId: 'happy-caretakers',
    storageBucket: 'happy-caretakers.appspot.com',
    iosBundleId: 'com.example.happyCaretakersClient',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAGZS42tTbVVYrqo2atXHAx6DRKskPClLA',
    appId: '1:796639206941:ios:415c23066824de63ebf0f4',
    messagingSenderId: '796639206941',
    projectId: 'happy-caretakers',
    storageBucket: 'happy-caretakers.appspot.com',
    iosBundleId: 'com.example.happyCaretakersClient.RunnerTests',
  );
}