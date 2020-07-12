import 'dart:convert';
import 'package:todoapp/database/todo_database.dart';
import 'package:todoapp/models/todo_class.dart';
import 'package:todoapp/services/http_helper.dart';

class Repository {
  TodoDatabase get getDatabase => TodoDatabase.instance;
  Future<List<ToDo>> getToDoData() async {
    try {
      var data = await HttpHelper.getData();
      var jsondata = jsonDecode(data) as List;
      return jsondata.map((e) => ToDo.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw NetworkError();
    }
  }
}

class NetworkError extends Error {}
