import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:true_tech_pro_bhargav/models/comment.dart';

abstract class BaseRepository{
  Future<List<Comment>?> getUserComments();
}
class Repository extends BaseRepository{
  @override
  Future<List<Comment>?> getUserComments()async{
    var url = "https://jsonplaceholder.typicode.com/comments";
    try {
      var response = await Dio().get(url);
      if(response.statusCode==200){
        final List t = response.data;
        List<Comment> comments = t.map((item) => Comment.fromJson(item)).toList();
        return comments;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

}