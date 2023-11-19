class DiscussionModel {
  String documentID,
      discussionPostedByImage,
      discussionPostedByName,
      postedTimeAgo,
      postDescription,
      postImage;
  int noOfLikes, noOfComments, numbersOfShares;

  DiscussionModel({
    required this.documentID,
    required this.discussionPostedByImage,
    required this.discussionPostedByName,
    required this.postedTimeAgo,
    required this.postDescription,
    required this.postImage,
    required this.noOfLikes,
    required this.noOfComments,
    required this.numbersOfShares,
  });
}
