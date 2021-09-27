class NoteModel {
  final int id;
  final String title;
  final String description;
  String date;
  int isDone;

  NoteModel({
    this.id = 0,
    required this.title,
    required this.description,
    required this.date,
    this.isDone = 0,
  });

  factory NoteModel.fromJSON(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {};

    json['title'] = title;
    json['description'] = description;
    json['date'] = date;
    json['isDone'] = isDone;

    return json;
  }
}
