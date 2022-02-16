class Notes {
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;

  Notes({this.id, this.title, this.description, this.dateTime});

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
        id: json['id'],
        title: json['title'],
        description: json['description'],
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
}
