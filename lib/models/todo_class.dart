class ToDo {
  int userId;
  int id;
  String title;
  bool completed;
  String details;
  ToDo(this.userId, this.id, this.title, this.completed);

  factory ToDo.fromJson(dynamic json) {
    return ToDo(json['userId'] as int, json['id'] as int,
        json['title'] as String, json['completed'] as bool);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'details': details};
  }
}
