import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalpaniksaathi/services/auth.dart';
import 'package:kalpaniksaathi/theme.dart';
import 'package:kalpaniksaathi/widgets/snackbar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:kalpaniksaathi/pages/chatbot/chatbot.dart';
import 'package:kalpaniksaathi/pages/posts/posts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int _currentIndex = 0;
  final tabs = [ChatPage(), Posts(), Posts()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleTextStyle: TextStyle(color: Theme.of(context).primaryColor),
          title: const Text('Kalpanik Saathi',
              style: TextStyle(
                fontFamily: 'Schoolbell',
                fontSize: 25,
                //change color according to theme
                // color: Colors.red,
              )),
          // backgroundColor: CustomTheme.loginGradientEnd,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          bottom: PreferredSize(
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 0.2,
              ),
              preferredSize: Size.fromHeight(4.0)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                onPressed: () async {
                  CustomSnackBar(context,
                      const Text('Tata 👋. Hope you have a great time ahead.'));
                  await _auth.signOut();
                },
                icon: const Icon(AntDesign.logout),
                label: const Text(''),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
              ),
            ),
          ],
        ),
        body: tabs[_currentIndex],
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Ionicons.heart_outline, size: 27),
                  label: '',
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AntDesign.smileo),
                  label: '',
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Ionicons.at,
                    size: 29,
                  ),
                  label: '',
                  tooltip: '',
                ),
              ],
              currentIndex: _currentIndex,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              // showTooltip: false,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  print(_currentIndex);
                });
                // }));
              }),
        ));
  }
}
