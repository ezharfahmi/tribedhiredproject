class CommentList {
  num? id;
  String? name;
  String? email;
  String? body;

  CommentList({this.id, this.name, this.email, this.body});

  CommentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }
}
