import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

@JsonSerializable()
class Messages {
  Messages(
      {required this.author,
      required this.createdAt,
      required this.id,
      required this.seen,
      required this.text,
      required this.type});

  factory Messages.fromJson(Map<String, dynamic> json) =>
      _$MessagesFromJson(json);

  factory Messages.fromSnapshot(DocumentSnapshot snapshot) {
    final newMsg = Messages.fromJson(snapshot.data() as Map<String, dynamic>);
    return newMsg;
  }

  final String? author;
  final int? createdAt;
  final String? id;
  final String? seen;
  final String? text;
  final String? type;

  Map<String, dynamic> toJson() => _$MessagesToJson(this);
}
