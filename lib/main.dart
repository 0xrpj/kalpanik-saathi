import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalpaniksaathi/pages/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: LoginPage(),
    );
  }
}
