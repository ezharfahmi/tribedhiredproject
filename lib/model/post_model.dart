class PostsList {
  num? id;
  String? title;
  String? body;

  PostsList({this.id, this.title, this.body});

  PostsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
}
