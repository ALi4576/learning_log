import 'dart:convert';

Settings_Stu settingsFromJson(String str) {
  final jsonData = json.decode(str);
  return Settings_Stu.fromMap(jsonData);
}

String settingsToJson(Settings_Stu data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Settings_Stu {
  int id;
  String Course_name;
  String Color_name;

  Settings_Stu({
    this.id,
    this.Course_name,
    this.Color_name,
  });

  factory Settings_Stu.fromMap(Map<String, dynamic> json) => new Settings_Stu(
    id: json["id"],
    Course_name: json["Course_name"],
    Color_name: json["Color_name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "Course_name": Course_name,
    "Color_name": Color_name,
  };
}


Help_Stu HelpFromJson(String str) {
  final jsonData = json.decode(str);
  return Help_Stu.fromMap(jsonData);
}

String HelpToJson(Settings_Stu data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Help_Stu {
  int id;
  String Helper_name;

  Help_Stu({
    this.id,
    this.Helper_name
  });

  factory Help_Stu.fromMap(Map<String, dynamic> json) => new Help_Stu(
    id: json["id"],
    Helper_name: json["Helper_name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "Helper_name": Helper_name,
  };
}