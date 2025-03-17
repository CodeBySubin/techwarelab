class HomeModel {
  int userId;
  int id;
  String title;
  bool completed;

  HomeModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "completed": completed,
  };
}
