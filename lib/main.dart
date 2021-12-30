import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalpaniksaathi/pages/authentication/login_page.dart';
import 'package:kalpaniksaathi/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //forcing the app to run in portrait mode
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kalpanik Saathi',
        home: Wrapper());
  }
}
