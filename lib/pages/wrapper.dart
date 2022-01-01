import 'package:flutter/material.dart';
import 'package:kalpaniksaathi/models/user.dart';
import 'package:kalpaniksaathi/pages/authentication/login_page.dart';
import 'package:kalpaniksaathi/pages/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Return either home or authentication widget
    // bool _isAuthenticated = false;

    // if (_isAuthenticated) {
    //   return const Home();
    // } else {
    final MyUser? user = Provider.of<MyUser?>(context);

    if (user == null) {
      return LoginPage();
    } else {
      return Home();
    }
    // }
  }
}
