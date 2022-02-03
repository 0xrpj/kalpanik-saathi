import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kalpaniksaathi/widgets/snackbar.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              // await _auth.signOut();
            },
            icon: const Icon(AntDesign.logout),
            label: const Text(''),
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor)),
          ),
        ),
      ],
    );
  }
}

// AppBar(
//           titleTextStyle: TextStyle(color: Theme.of(context).primaryColor),
//           title: const Text('Kalpanik Saathi',
//               style: TextStyle(
//                 fontFamily: 'Schoolbell',
//                 fontSize: 25,
//                 //change color according to theme
//                 // color: Colors.red,
//               )),
//           // backgroundColor: CustomTheme.loginGradientEnd,
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           bottom: PreferredSize(
//               child: Container(
//                 color: Theme.of(context).primaryColor,
//                 height: 0.2,
//               ),
//               preferredSize: Size.fromHeight(4.0)),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextButton.icon(
//                 onPressed: () async {
//                   CustomSnackBar(context,
//                       const Text('Tata 👋. Hope you have a great time ahead.'));
//                   await _auth.signOut();
//                 },
//                 icon: const Icon(AntDesign.logout),
//                 label: const Text(''),
//                 style: ButtonStyle(
//                     foregroundColor: MaterialStateProperty.all(
//                         Theme.of(context).primaryColor)),
//               ),
//             ),
//           ],
//         ),