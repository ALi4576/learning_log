import 'dart:convert';

form_model settingsFromJson(String str) {
  final jsonData = json.decode(str);
  return form_model.fromMap(jsonData);
}

String settingsToJson(form_model data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class form_model {
  int id;
  String Course_name;
  String Color_name;
  String Helpers_name;
  String learn_to;
  String prepare_to;
  String practice_to;
  int do_date;
  int due_date;
  int est_min;
  int act_min;
  int review_1;
  int review_2;
  String notes_to;
  int complete;
  int sort;

  form_model({
    this.id,
    this.Course_name,
    this.Color_name,
    this.Helpers_name ,
    this.learn_to ,
    this.prepare_to ,
    this.practice_to ,
    this.do_date ,
    this.due_date ,
    this.est_min ,
    this.act_min ,
    this.review_1,
    this.review_2,
    this.notes_to,
    this.complete,
    this.sort
  });

  factory form_model.fromMap(Map<String, dynamic> json) => new form_model(
    id: json["id"],
    Course_name: json["Course_name"],
    Color_name: json["Color_name"],
    Helpers_name: json["Helpers_name"],
    learn_to: json["learn_to"],
    prepare_to: json["prepare_to"],
    practice_to: json["practice_to"],
    do_date: json["do_date"],
    due_date: json["due_date"],
    est_min: json["est_min"],
    act_min: json["act_min"],
    review_1: json["review_1"],
    review_2: json["review_2"],
    notes_to: json["notes_to"],
    complete: json["complete"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "Course_name": Course_name,
    "Color_name": Color_name,
    "Helpers_name": Helpers_name,
    "learn_to": learn_to,
    "prepare_to": prepare_to,
    "practice_to": practice_to,
    "do_date": do_date,
    "due_date": due_date,
    "est_min": est_min,
    "act_min": act_min,
    "review_1": review_1,
    "review_2": review_2,
    "notes_to": notes_to,
    "complete": complete
  };
}