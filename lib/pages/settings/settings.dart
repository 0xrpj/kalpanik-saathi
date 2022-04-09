import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kalpaniksaathi/services/auth.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: const Key('settings_page'),
      child: Scaffold(
        body: Container(
          child: SettingsList(
            sections: [
              SettingsSection(
                title: Text('Account'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: const Icon(SimpleLineIcons.logout),
                    title: const Text('Log out'),
                    value: const Text('Log out from the current device'),
                    onPressed: (BuildContext context) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Are you sure?',
                        desc: 'You are about to log out.',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          await _auth.signOut();
                          Navigator.pop(context);
                        },
                      ).show();
                    },
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(AntDesign.delete),
                    title: const Text('Wipe my data'),
                    value: const Text(
                        'This will permanently delete your data and account'),
                    onPressed: (BuildContext context) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Are you sure to erase everything?',
                        desc: 'This action cannot be undone!',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          await _auth.deleteUser();
                          Navigator.pop(context);
                        },
                      ).show();
                    },
                  ),
                  // SettingsTile.switchTile(
                  //   onToggle: (value) {},
                  //   initialValue: true,
                  //   leading: Icon(Icons.format_paint),
                  //   title: Text('Enable custom theme'),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
