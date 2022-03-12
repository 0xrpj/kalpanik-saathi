import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String? postId;
  String? userId;
  String? commentContent;
  int? createdAt;

  Comment({this.postId, this.userId, this.commentContent, this.createdAt});

  factory Comment.fromSnapshot(DocumentSnapshot snapshot) {
    final newComment =
        Comment.fromJson(snapshot.data() as Map<String, dynamic>);
    newComment.postId = snapshot.reference.id;
    return newComment;
  }

  factory Comment.fromJson(Map<String, dynamic> json) => _commentFromJson(json);

  Map<String, dynamic> toJson() => _commentToJson(this);
}

Comment _commentFromJson(Map<String, dynamic> json) {
  return Comment(
    postId: json['postId'] as String,
    userId: json['userId'] as String?,
    commentContent: json['commentContent'] as String?,
    createdAt: json['createdAt'] as int?,
  );
}

Map<String, dynamic> _commentToJson(Comment instance) => <String, dynamic>{
      'postId': instance.postId,
      'userId': instance.userId,
      'commentContent': instance.commentContent,
      'createdAt': instance.createdAt,
    };
