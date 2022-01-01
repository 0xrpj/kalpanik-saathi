import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalpaniksaathi/services/auth.dart';
import 'package:kalpaniksaathi/theme.dart';
import 'package:kalpaniksaathi/widgets/snackbar.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Kalpanik Saathi'),
        backgroundColor: CustomTheme.loginGradientEnd,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
              onPressed: () async {
                CustomSnackBar(context,
                    const Text('Tata 👋. Hope you have a great time ahead.'));
                await _auth.signOut();
              },
              icon: const Icon(Icons.door_back_door),
              label: const Text('Log out'),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
