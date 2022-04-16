import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kalpaniksaathi/pages/chatbot/chatbot.dart';
import 'package:kalpaniksaathi/pages/podcast/listen_page.dart';
import 'package:kalpaniksaathi/pages/posts/posts.dart';
import 'package:kalpaniksaathi/pages/widgets/appbar.dart';
import 'package:kalpaniksaathi/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int _currentIndex = 1;
  final tabs = [const ChatPage(), const Posts(), const ListenPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.grey.shade300,
                //       spreadRadius: 0,
                //       blurRadius: 1),
                // ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
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
                      // selectedItemColor: Theme.of(context).primaryColor,
                      unselectedItemColor: Colors.grey,
                      elevation: 0.0,
                      backgroundColor: Theme.of(context).primaryColorLight,
                      // showTooltip: false,
                      onTap: (index) {
                        setState(() {
                          _currentIndex = index;
                          print(_currentIndex);
                        });
                      }),
                ),
              ),
            ),
          )
        ]));
  }
}
