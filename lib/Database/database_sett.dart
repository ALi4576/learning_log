import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_planner/Models/form_model.dart';
import 'package:student_planner/Models/settingsModel.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "studentPlanDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) => _createDb(db)
    );
  }

  static void _createDb(Database db) {
     db.execute('CREATE TABLE Settings (id INTEGER PRIMARY KEY,Course_name TEXT,Color_name TEXT)');
     db.execute('CREATE TABLE Helpers (id INTEGER PRIMARY KEY,Helper_name TEXT)');
     db.execute('CREATE TABLE Assign_Form (id INTEGER PRIMARY KEY AUTOINCREMENT,Course_name TEXT,Color_name TEXT,Helpers_name TEXT,learn_to TEXT,prepare_to TEXT,practice_to TEXT,do_date INTEGER,due_date INTEGER,est_min INTEGER,act_min INTEGER,review_1 INTEGER,review_2 INTEGER,notes_to TEXT,complete INTEGER)');
  }

  /*Settings Screen*/

  //Insert Course
  newSettings(Settings_Stu newClient) async {
    final db = await database;
    var check = await db.rawQuery("SELECT * FROM Settings WHERE id = (${newClient.id})");
    if(check.isEmpty){
      var res = await db.rawInsert('INSERT Into Settings(id,Course_name,Color_name) VALUES (?,?,?)',[newClient.id,newClient.Course_name,newClient.Color_name]);
      return res;
    }
    else{
      var res = await db.update("Settings", newClient.toMap(),
          where: "id = ?", whereArgs: [newClient.id]);
      return res;

    }
  }

  //Delete Course
  deleteClient(int id) async {
    final db = await database;
    return db.delete("Settings", where: "id = ?", whereArgs: [id]);
  }

  //Get All courses
  Future<List<Settings_Stu>> getAllSettings() async {
    final db = await database;
    var res = await db.query("Settings");
    List<Settings_Stu> list =
    res.isNotEmpty ? res.map((c) => Settings_Stu.fromMap(c)).toList() : null;
    return list;
  }

//delete all
  Future<String> deleteall() async {
    final db = await database;
    db.delete("Settings");
    db.delete("Helpers");
    db.delete("Assign_Form");
    return "Deleted";
  }

  //Get Course id
  getID(String name) async{
    final db = await database;
    var res = await db.query("Settings",where: "Course_name = ?",whereArgs: [name]);
    List<Settings_Stu> list =
    res.isNotEmpty ? res.map((c) => Settings_Stu.fromMap(c)).toList() : null;
    return list;
  }

  //Insert Helpers
  newHelp(Help_Stu newClient) async {
    final db = await database;
    var res = await db.rawInsert('INSERT Into Helpers(Helper_name) VALUES (?)',[newClient.Helper_name]);
    return res;
  }

  //Delete Helpers
  deleteHelp(int id) async {
    final db = await database;
    return db.delete("Helpers", where: "id = ?", whereArgs: [id]);
  }

  //Get ALl Helpers
  Future<List<Help_Stu>> getAllHelp() async {
    final db = await database;
    var res = await db.query("Helpers");
    List<Help_Stu> list =
    res.isNotEmpty ? res.map((c) => Help_Stu.fromMap(c)).toList() : null;
    return list;
  }

  //Get Help id
  getHelpID(String name) async{
    final db = await database;
    var res = await db.query("Helpers",where: "Helper_name = ?",whereArgs: [name]);
    List<Help_Stu> list =
    res.isNotEmpty ? res.map((c) => Help_Stu.fromMap(c)).toList() : null;
    return list;
  }

  /*Assign_Form*/

  //insert
  Future<String> form_insert(form_model data) async{
    final db = await database;
    String color = data.Color_name;
    print(data.complete.toString());
    String val = color;
      var res = await db.rawInsert('INSERT Into Assign_Form(Course_name,Color_name,Helpers_name,learn_to,prepare_to,practice_to,do_date,due_date,est_min,act_min,review_1,review_2,notes_to,complete) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)',[data.Course_name,val,data.Helpers_name,
        data.learn_to,data.prepare_to,data.practice_to,data.do_date,data.due_date,data.est_min,data.act_min,data.review_1,data.review_2,data.notes_to,data.complete]);
      return "Success";
  }

  //delete
  deleteForm(int id) async {
    final db = await database;
    return db.delete("Assign_Form", where: "id = ?", whereArgs: [id]);
  }

  //get_all order_by do date
  Future<List<form_model>> getAllform_do(int comp,String date) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Assign_Form WHERE complete = ? ORDER BY ?",[comp,date]);
    List<form_model> list =
    res.isNotEmpty ? res.map((c) => form_model.fromMap(c)).toList() : null;
    return list;
  }

  //show_all
  Future<List<form_model>> showAllform_due() async {
    final db = await database;
    var res = await db.query("Assign_Form");
    List<form_model> list =  res.isNotEmpty ? res.map((c) => form_model.fromMap(c)).toList() : null;
    List<form_model> sorting = <form_model>[];
    for(int i = 0;i<list.length;i++){
      form_model fm = new form_model();
      fm.complete = list[i].complete;
      fm.do_date = list[i].do_date;
      fm.review_1 = list[i].review_1;
      fm.review_2 = list[i].review_2;
      fm.act_min = list[i].act_min;
      fm.Course_name = list[i].Course_name;
      fm.Color_name = list[i].Color_name;
      fm.id = list[i].id;
      fm.notes_to = list[i].notes_to;
      fm.due_date = list[i].due_date;
      fm.est_min = list[i].est_min;
      fm.learn_to = list[i].learn_to;
      fm.prepare_to = list[i].prepare_to;
      fm.practice_to = list[i].practice_to;
      fm.Helpers_name = list[i].Helpers_name;
      sorting.add(fm);
    }
    sorting.sort((a,b) => a.do_date.compareTo(b.do_date));
    return sorting;
  }

  //Todo
  Future<List<form_model>> Todoform_do() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Assign_Form WHERE (review_1 IS NOT NULL AND complete = 1) OR (review_2 IS NOT NULL AND complete = 1)  OR (complete = 0) ORDER BY "
        "(CASE WHEN review_1 IS NOT NULL THEN review_1 WHEN review_2 IS NOT NULL THEN review_2 ELSE do_date END)");
    List<form_model> list =
    res.isNotEmpty ? res.map((c) => form_model.fromMap(c)).toList() : null;
    List<form_model> sorting = <form_model>[];
    for(int i = 0;i<list.length;i++){
      if(list[i].complete == 0 && list[i].do_date >= DateTime.now().millisecondsSinceEpoch && list[i].review_1 == 0 && list[i].review_2 == 0){
        form_model fm = new form_model();
        fm.complete = 0;
        fm.do_date = list[i].do_date;
        fm.review_1 = list[i].review_1;
        fm.review_2 = list[i].review_2;
        fm.act_min = list[i].act_min;
        fm.Course_name = list[i].Course_name;
        fm.Color_name = list[i].Color_name;
        fm.id = list[i].id;
        fm.notes_to = list[i].notes_to;
        fm.due_date = list[i].due_date;
        fm.est_min = list[i].est_min;
        fm.learn_to = list[i].learn_to;
        fm.prepare_to = list[i].prepare_to;
        fm.practice_to = list[i].practice_to;
        fm.sort = list[i].do_date;
        fm.Helpers_name = list[i].Helpers_name;
        sorting.add(fm);
      }
      else if(list[i].complete == 0 && list[i].do_date < DateTime.now().millisecondsSinceEpoch && (list[i].review_1 == 0 || list[i].review_2 == 0)){
        form_model fm = new form_model();
        fm.complete = 0;
        fm.do_date = list[i].do_date;
        fm.review_1 = list[i].review_1;
        fm.review_2 = list[i].review_2;
        fm.act_min = list[i].act_min;
        fm.Course_name = list[i].Course_name;
        fm.Color_name = list[i].Color_name;
        fm.id = list[i].id;
        fm.notes_to = list[i].notes_to;
        fm.due_date = list[i].due_date;
        fm.est_min = list[i].est_min;
        fm.learn_to = list[i].learn_to;
        fm.prepare_to = list[i].prepare_to;
        fm.practice_to = list[i].practice_to;
        fm.sort = list[i].do_date;
        fm.Helpers_name = list[i].Helpers_name;
        sorting.add(fm);
      }
      else if (list[i].complete == 1 && list[i].review_2 < DateTime.now().millisecondsSinceEpoch && list[i].review_1 < DateTime.now().millisecondsSinceEpoch){
        form_model fm = new form_model();
        fm.complete = 1;
        fm.do_date = list[i].do_date;
        fm.review_1 = list[i].review_1;
        fm.review_2 = list[i].review_2;
        fm.act_min = list[i].act_min;
        fm.Course_name = list[i].Course_name;
        fm.Color_name = list[i].Color_name;
        fm.id = list[i].id;
        fm.notes_to = list[i].notes_to;
        fm.due_date = list[i].due_date;
        fm.est_min = list[i].est_min;
        fm.learn_to = list[i].learn_to;
        fm.prepare_to = list[i].prepare_to;
        fm.practice_to = list[i].practice_to;
        fm.sort = list[i].do_date;
        fm.Helpers_name = list[i].Helpers_name;
        sorting.add(fm);
      }
      else if(list[i].complete == 1 && list[i].review_1 >= DateTime.now().millisecondsSinceEpoch && list[i].review_2 == 0){
        form_model fm = new form_model();
        fm.complete = 1;
        fm.do_date = list[i].do_date;
        fm.review_1 = list[i].review_1;
        fm.review_2 = list[i].review_2;
        fm.act_min = list[i].act_min;
        fm.Course_name = list[i].Course_name;
        fm.Color_name = list[i].Color_name;
        fm.id = list[i].id;
        fm.notes_to = list[i].notes_to;
        fm.due_date = list[i].due_date;
        fm.est_min = list[i].est_min;
        fm.learn_to = list[i].learn_to;
        fm.prepare_to = list[i].prepare_to;
        fm.practice_to = list[i].practice_to;
        fm.Helpers_name = list[i].Helpers_name;
        fm.sort = list[i].review_1;
        sorting.add(fm);
      }
      else if(list[i].complete == 1 && list[i].review_2 >= DateTime.now().millisecondsSinceEpoch && list[i].review_1 == 0){
        form_model fm = new form_model();
        fm.complete = 1;
        fm.do_date = list[i].do_date;
        fm.review_1 = list[i].review_1;
        fm.review_2 = list[i].review_2;
        fm.act_min = list[i].act_min;
        fm.Course_name = list[i].Course_name;
        fm.Color_name = list[i].Color_name;
        fm.id = list[i].id;
        fm.notes_to = list[i].notes_to;
        fm.due_date = list[i].due_date;
        fm.est_min = list[i].est_min;
        fm.learn_to = list[i].learn_to;
        fm.prepare_to = list[i].prepare_to;
        fm.practice_to = list[i].practice_to;
        fm.Helpers_name = list[i].Helpers_name;
        fm.sort = list[i].review_2;
        sorting.add(fm);
      }
      else if(list[i].complete == 1 && list[i].review_2 >= DateTime.now().millisecondsSinceEpoch && list[i].review_1 >= DateTime.now().millisecondsSinceEpoch){
        form_model fm = new form_model();
        if(list[i].review_1 > list[i].review_2){
          fm.sort = list[i].review_2;
        }
        else{
          fm.sort = list[i].review_1;
        }
        fm.complete = 1;
        fm.do_date = list[i].do_date;
        fm.review_1 = list[i].review_1;
        fm.review_2 = list[i].review_2;
        fm.act_min = list[i].act_min;
        fm.Course_name = list[i].Course_name;
        fm.Color_name = list[i].Color_name;
        fm.id = list[i].id;
        fm.notes_to = list[i].notes_to;
        fm.due_date = list[i].due_date;
        fm.est_min = list[i].est_min;
        fm.learn_to = list[i].learn_to;
        fm.prepare_to = list[i].prepare_to;
        fm.practice_to = list[i].practice_to;
        fm.Helpers_name = list[i].Helpers_name;
        sorting.add(fm);
      }
      else if(list[i].do_date >= DateTime.now().millisecondsSinceEpoch && (list[i].review_1 >= DateTime.now().millisecondsSinceEpoch || list[i].review_2 >= DateTime.now().millisecondsSinceEpoch ) || list[i].complete == 0){
        form_model fm = new form_model();
        fm.complete = fm.complete;
        fm.do_date = list[i].do_date;
        fm.Helpers_name = list[i].Helpers_name;
        fm.review_1 = list[i].review_1;
        fm.review_2 = list[i].review_2;
        fm.act_min = list[i].act_min;
        fm.Course_name = list[i].Course_name;
        fm.Color_name = list[i].Color_name;
        fm.id = list[i].id;
        fm.notes_to = list[i].notes_to;
        fm.due_date = list[i].due_date;
        fm.est_min = list[i].est_min;
        fm.learn_to = list[i].learn_to;
        fm.prepare_to = list[i].prepare_to;
        fm.practice_to = list[i].practice_to;
        fm.sort = list[i].do_date;
        sorting.add(fm);
      }
      else if((list[i].review_1 > 0 || list[i].review_2 > 0) && (list[i].review_1 >= DateTime.now().millisecondsSinceEpoch || list[i].review_2 >= DateTime.now().millisecondsSinceEpoch)){
        form_model fm = new form_model();
        if(list[i].review_1 > list[i].review_2){
          fm.sort = list[i].review_1;
        }
        else{
          fm.sort = list[i].review_2;
        }
        fm.complete = fm.complete;
        fm.do_date = list[i].do_date;
        fm.Helpers_name = list[i].Helpers_name;
        fm.review_1 = list[i].review_1;
        fm.review_2 = list[i].review_2;
        fm.act_min = list[i].act_min;
        fm.Course_name = list[i].Course_name;
        fm.Color_name = list[i].Color_name;
        fm.id = list[i].id;
        fm.notes_to = list[i].notes_to;
        fm.due_date = list[i].due_date;
        fm.est_min = list[i].est_min;
        fm.learn_to = list[i].learn_to;
        fm.prepare_to = list[i].prepare_to;
        fm.practice_to = list[i].practice_to;
        sorting.add(fm);
      }
    }
    sorting.sort((a,b) => a.sort.compareTo(b.sort));
    return sorting;
  }


  //Update
  Future<String> Update_form(form_model data) async {
    final db = await database;
    var res = await db.update("Assign_Form", data.toMap(),
        where: "id = ?", whereArgs: [data.id]);
    return "Success";
  }

}