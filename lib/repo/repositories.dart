import 'dart:convert';

import 'package:tribed_hired_assessment/model/comment_model.dart';
import 'package:http/http.dart';

import '../model/post_model.dart';
import 'endpoint.dart';

class PostRepository {
  Future<List<PostsList>> getPosts() async {
    Response response = await get(Uri.parse(getPostsEndpoint));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => PostsList.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<CommentList>> getComment(num id) async {
    Response response = await get(Uri.parse('$getCommentEndpoint?postId=$id'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => CommentList.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
