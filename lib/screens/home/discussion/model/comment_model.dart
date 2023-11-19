import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tonyyaooo/service/firestore_service.dart';

import '../../../../utils/constants/constant_lists.dart';

class CommentModel {
  String? id;
  String? userId;
  String? userName;
  String? content;
  // String? imageUrl;
  List<String>? likedBy;
  // List<String>? collectedBy;
  // List<String>? sharedBy;
  Timestamp? createdAt;
  CommentModel({
    this.id,
    this.content,
    // this.imageUrl,
    this.userName,
    // this.sharedBy,
    this.userId,
    this.likedBy,
    // this.collectedBy,
    this.createdAt,
  });
  CommentModel.fromJson(Object? json) {
    json as Map<String, dynamic>?;
    id = json?['id'];
    userId = json?['userId'];
    userName = json?['userName'];
    // imageUrl = json?['imageUrl'];
    content = json?['content'];
    createdAt = json?['createdAt'];
    likedBy = json?['likedBy']?.cast<String>();
    // collectedBy = json?['collectedBy']?.cast<String>();
    // sharedBy = json?['sharedBy']?.cast<String>();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['userName'] = userName;
    // data['imageUrl'] = imageUrl;
    data['content'] = content;
    data['createdAt'] = createdAt;
    // data['collectedBy'] = collectedBy;
    data['likedBy'] = likedBy;
    // data['sharedBy'] = sharedBy;
    return data;
  }
}

extension SetComment on CommentModel {
  Future<bool> setComment(String? postId) async {
    try {
      final docRef = FirestoreService.postCommentsCollection(postId).doc();
      id = docRef.id;
      await docRef.set(toJson());
      return true;
    } catch (e) {
      print((e));
    }
    return false;
  }

  Future<bool> update(String? postId) async {
    try {
      await FirestoreService.postCommentsCollection(postId)
          .doc(id)
          .update(toJson());

      return true;
    } catch (e) {
      print((e));
    }
    return false;
  }
}
