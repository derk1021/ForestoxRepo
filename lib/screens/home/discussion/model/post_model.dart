import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../service/firestore_service.dart';
import '../../../../utils/constants/constant_lists.dart';

class PostModel {
  String? id;
  String? userId;
  String? userName;
  String? content;
  String? imageUrl;
  List<String>? likedBy;
  List<String>? collectedBy;
  List<String>? sharedBy;
  Timestamp? createdAt;
  PostModel({
    this.id,
    this.content,
    this.imageUrl,
    this.userName,
    this.sharedBy,
    this.userId,
    this.likedBy,
    this.collectedBy,
    this.createdAt,
  });
  PostModel.fromJson(Object? json) {
    json as Map<String, dynamic>?;
    id = json?['id'];
    userId = json?['userId'];
    userName = json?['userName'];
    imageUrl = json?['imageUrl'];
    content = json?['content'];
    createdAt = json?['createdAt'];
    likedBy = json?['likedBy']?.cast<String>();
    collectedBy = json?['collectedBy']?.cast<String>();
    sharedBy = json?['sharedBy']?.cast<String>();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['userName'] = userName;
    data['imageUrl'] = imageUrl;
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['collectedBy'] = collectedBy;
    data['likedBy'] = likedBy;
    data['sharedBy'] = sharedBy;
    return data;
  }
}

extension UpdatePost on PostModel {
  Future<bool> update() async {
    try {
      await FirestoreService.postsCollection.doc(id).update(toJson());
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
