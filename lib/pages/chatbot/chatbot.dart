import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kalpaniksaathi/models/messages.dart';
import 'package:kalpaniksaathi/repository/data_repository.dart';
// import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:kalpaniksaathi/services/auth.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: 'ro');
  final _userBot = const types.User(id: 'bot');
  final DataRepository repository = DataRepository();
  final AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

    //send message to db here
    final messageDB = Messages(
        author: "Rasa",
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: auth.getUser().uid.toString(),
        seen: "false",
        text: message.text,
        type: "text");

    repository.addMessage(messageDB);

    //send message to rasa here

    final queryParameters = {
      'message': message.text,
      // 'sender': 'Roshan',
    };
    final String apiUri =
        'https://levchatbot.herokuapp.com/webhooks/rest/webhook/';

    // final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response =
        await http.post(Uri.parse(apiUri), body: json.encode(queryParameters));

    final responseJson = json.decode(response.body)[0]['text'].toString();

    final textMessage2 = types.TextMessage(
      author: _userBot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: responseJson,
    );

    _addMessage(textMessage2);
  }

  void _loadMessages() async {
    final String user_id = auth.getUser().uid.toString();
    final QuerySnapshot<Map<String, dynamic>> msg_db = await repository
        .getMessages(user_id) as QuerySnapshot<Map<String, dynamic>>;

    msg_db.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      final Messages postdata = Messages.fromSnapshot(doc);

      final textMessage = types.TextMessage(
        author: _user,
        createdAt: postdata.createdAt,
        id: postdata.id.toString(),
        text: postdata.text.toString(),
      );

      _addMessage(textMessage);
    });

    // final response = await rootBundle.loadString('assets/messages.json');
    // final messages = (jsonDecode(response) as List)
    //     .map((dynamic e) => types.Message.fromJson(e as Map<String, dynamic>))
    //     .toList();
    // setState(() {
    //   _messages = messages;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).primaryColor;
    print(themedata == Color(0xffffffff));
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
          child: Chat(
            showUserAvatars: true,
            theme: DefaultChatTheme(
                secondaryColor: Colors.deepPurple.shade900,
                primaryColor: Colors.deepPurple.shade900,
                sentMessageBodyTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                receivedMessageBodyTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                inputBackgroundColor:
                    Theme.of(context).primaryColor == const Color(0xffffffff)
                        ? Colors.white30
                        // : const Color.fromRGBO(43, 10, 69, 0.9),
                        : Colors.deepPurple.shade900,
                // inputTextStyle: TextStyle(color: Colors.black),
                inputBorderRadius: BorderRadius.circular(10),
                inputTextStyle: const TextStyle(
                    // fontFamily: 'Schoolbell'
                    ),
                inputPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                sendButtonIcon: const Icon(
                  AntDesign.right,
                  color: Colors.white,
                ),
                deliveredIcon: const Icon(
                  AntDesign.check,
                  color: Colors.white,
                )),
            messages: _messages,
            // onAttachmentPressed: _handleAtachmentPressed,
            onMessageTap: _handleMessageTap,
            onPreviewDataFetched: _handlePreviewDataFetched,
            onSendPressed: _handleSendPressed,
            user: _user,
          ),
        ),
      ),
    );
  }
}
