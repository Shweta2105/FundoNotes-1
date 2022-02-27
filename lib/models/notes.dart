class NotesField {
  static final List<String> values = [id, title, body, time];
  static final String id = 'id';
  static final String title = 'title';
  static final String body = 'body';
  static final String time = 'time';
}

class Notes {
  String? id;
  int? iid;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? archive;

  Notes(
      {this.id,
      this.iid,
      this.title,
      this.description,
      this.dateTime,
      this.archive});

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        archive: json['archive'],
        dateTime: json['created'] as DateTime);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    //data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    // data['created'] = this.dateTime;

    return data;
  }

  Map<String, dynamic> toSqJson() => {
        NotesField.id: iid,
        NotesField.title: title,
        NotesField.body: description,
        NotesField.time: dateTime!.toIso8601String(),
      };

  static Notes fromSqJson(Map<String, Object?> json) => Notes(
        iid: json[NotesField.id] as int?,
        title: json[NotesField.title] as String,
        description: json[NotesField.body] as String,
        dateTime: DateTime.parse(json[NotesField.time] as String),
      );

  Notes copy({
    int? id,
    String? title,
    String? description,
    DateTime? dateTime,
  }) =>
      Notes(
          iid: iid ?? this.iid,
          title: title ?? this.title,
          description: description ?? this.description,
          dateTime: dateTime ?? this.dateTime);
}
