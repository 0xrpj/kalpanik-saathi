import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalpaniksaathi/pages/widgets/appbar.dart';
import 'package:kalpaniksaathi/pages/posts/post_detail.dart';
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
  final tabs = [ChatPage(), Posts(), PostDetail()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: AppBarWidget()),
        body: Stack(children: [
          tabs[_currentIndex],
          Positioned(
            left: 10,
            right: 10,
            // bottom should be device bottom
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 0,
                      blurRadius: 8),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                  // ),
                ),
                child: SizedBox(
                  height: 60,
                  child: BottomNavigationBar(
                      // backgroundColor: Theme.of(context).primaryColor,
                      enableFeedback: true,
                      type: BottomNavigationBarType.fixed,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(Ionicons.heart_outline, size: 27),
                          label: 'Chat',
                          tooltip: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(AntDesign.smileo),
                          label: 'Home',
                          tooltip: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Ionicons.at,
                            size: 29,
                          ),
                          label: 'Space',
                          tooltip: '',
                        ),
                      ],
                      currentIndex: _currentIndex,
                      selectedItemColor: Theme.of(context).primaryColor,
                      unselectedItemColor: Colors.grey,
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                      // showTooltip: false,
                      onTap: (index) {
                        setState(() {
                          _currentIndex = index;
                          print(_currentIndex);
                        });
                        // }));
                      }),
                ),
              ),
            ),
          )
        ])
        // bottomNavigationBar: Theme(
        //   data: ThemeData(
        //     splashColor: Colors.transparent,
        //     highlightColor: Colors.transparent,
        //   ),
        //   child:
        // )
        );
  }
}
