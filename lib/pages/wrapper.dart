import 'package:flutter/material.dart';
import 'package:kalpaniksaathi/pages/authentication/login_page.dart';
import 'package:kalpaniksaathi/pages/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Return either home or authentication widget
    // bool _isAuthenticated = false;

    // if (_isAuthenticated) {
    //   return const Home();
    // } else {
    return const LoginPage();
    // }
  }
}
