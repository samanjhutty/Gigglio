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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_9RS6aGByAtw4ajkNiW_Y0QArlHnofJo',
    appId: '1:445987609145:android:6b8585f8035edf102b8be8',
    messagingSenderId: '445987609145',
    projectId: 'gigglio',
    storageBucket: 'gigglio.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbxJnMafcPaJnvJ6tVDYCAnAl5Qn9Uwbk',
    appId: '1:445987609145:ios:5febd0ad11abe9932b8be8',
    messagingSenderId: '445987609145',
    projectId: 'gigglio',
    storageBucket: 'gigglio.appspot.com',
    androidClientId: '445987609145-r0doen8u3ui4rrt71o9sips57ogeqkkt.apps.googleusercontent.com',
    iosClientId: '445987609145-v67iuvd3qqjp9ibutnlhrj5msdnaasrg.apps.googleusercontent.com',
    iosBundleId: 'com.samtech.gigglio',
  );

}