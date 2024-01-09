import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyATyrxMUWo-KhxocCXzrdYUPAJ7FwnqnLk",
            authDomain: "fitlink2.firebaseapp.com",
            projectId: "fitlink2",
            storageBucket: "fitlink2.appspot.com",
            messagingSenderId: "25172715635",
            appId: "1:25172715635:web:9b13b2f115a4333c71a206"));
  } else {
    await Firebase.initializeApp();
  }
}
