import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  // String postContent;

  String? postId;
  String? userId;
  String? postContent;
  int? createdAt;

  // String? postHeader;

  Post(this.postId, {this.userId, this.postContent, this.createdAt});

  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    final newPost = Post.fromJson(snapshot.data() as Map<String, dynamic>);
    newPost.postId = snapshot.reference.id;
    return newPost;
  }

  factory Post.fromJson(Map<String, dynamic> json) => _postFromJson(json);

  Map<String, dynamic> toJson() => _postToJson(this);
}

Post _postFromJson(Map<String, dynamic> json) {
  return Post(
    json['postId'] as String,
    userId: json['userId'] as String?,
    postContent: json['postContent'] as String?,
    createdAt: json['createdAt'] as int?,
    // postHeader: json['postHeader'] as String?,
  );
}

Map<String, dynamic> _postToJson(Post instance) => <String, dynamic>{
      'postId': instance.postId,
      'userId': instance.userId,
      'postContent': instance.postContent,
      'createdAt': instance.createdAt,
      // 'postHeader': instance.postHeader
    };
