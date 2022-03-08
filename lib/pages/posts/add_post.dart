import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalpaniksaathi/models/posts.dart';
import 'package:kalpaniksaathi/repository/data_repository.dart';
import 'package:kalpaniksaathi/services/auth.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final User _currentUser = AuthService().getUser();
  final DataRepository repository = DataRepository();
  final TextEditingController _postBodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(18.0),
          // color: Colors.white60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Share your feelings',
              style: TextStyle(fontFamily: 'WorkSansMedium', fontSize: 17),
            ),
            const SizedBox(
              height: 22,
            ),
            TextField(
              controller: _postBodyController,
              style: TextStyle(
                height: 5.0,
              ),
              maxLines: null,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Write',
                  labelStyle: TextStyle(
                    fontFamily: 'WorkSansMedium',
                    fontSize: 15,
                  ),
                  focusColor: Color(0xFF88C03D)

                  // isDense: true,
                  // contentPadding: EdgeInsets.all(28),
                  ),
            ),
            const SizedBox(
              height: 22,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF00AC97)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ))),
              onPressed: () {
                // getPosts();
                final newPost = Post('post1',
                    userId: _currentUser.uid.toString(),
                    postContent: _postBodyController.text,
                    createdAt: DateTime.now().millisecondsSinceEpoch);
                repository.addPost(newPost);
                print('posted');

                // setState(() {
                //   _postBodyController.clear();
                //   didChangeDependencies();
                // });
              },
              child: const Text('Share',
                  style: TextStyle(fontSize: 15, fontFamily: 'WorkSansMedium')),
            ),
          ]),
        ),
      ),
    );
  }
}
