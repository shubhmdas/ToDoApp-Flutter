// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCfeCybTI4lIGy1QbNwOYEea5mhzD5UIeE',
    appId: '1:1080512392924:web:1ea1e72a05e0fa95514e19',
    messagingSenderId: '1080512392924',
    projectId: 'flutter-to-do-6c6db',
    authDomain: 'flutter-to-do-6c6db.firebaseapp.com',
    storageBucket: 'flutter-to-do-6c6db.appspot.com',
    measurementId: 'G-MEJ7GQ8R7F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQ2YtDGr40nlxHfB1-jLx7OR7SCDBCNUg',
    appId: '1:1080512392924:android:59872cb6afbe0d3c514e19',
    messagingSenderId: '1080512392924',
    projectId: 'flutter-to-do-6c6db',
    storageBucket: 'flutter-to-do-6c6db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBH6treIpZHpOX9GVJqNlOErqsoKz61ZWA',
    appId: '1:1080512392924:ios:5dc690bbc321ee2d514e19',
    messagingSenderId: '1080512392924',
    projectId: 'flutter-to-do-6c6db',
    storageBucket: 'flutter-to-do-6c6db.appspot.com',
    iosClientId: '1080512392924-u2itc0f5on6564froehv22lmcm5amd46.apps.googleusercontent.com',
    iosBundleId: 'com.todoapp.app',
  );
}
