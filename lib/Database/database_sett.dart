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
     db.execute('CREATE TABLE Settings (id INTEGER PRIMARY KEY AUTOINCREMENT,Course_name TEXT,Color_name TEXT)');
     db.execute('CREATE TABLE Helpers (id INTEGER PRIMARY KEY,Helper_name TEXT)');
     db.execute('CREATE TABLE Assign_Form (id INTEGER PRIMARY KEY AUTOINCREMENT,Course_name TEXT,Color_name TEXT,Helpers_name TEXT,learn_to TEXT,prepare_to TEXT,practice_to TEXT,do_date INTEGER,due_date INTEGER,est_min INTEGER,act_min INTEGER,review_to TEXT,notes_to TEXT,complete INTEGER)');
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

  /*updateClient(Settings_Stu newClient) async {
    final db = await database;
    var res = await db.update("Settings", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }*/

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
  /*
  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }*/


  /*Assign_Form*/

  //insert
  Future<String> form_insert(form_model data) async{
    final db = await database;
    String color = data.Color_name;
    String val = color;
      var res = await db.rawInsert('INSERT Into Assign_Form(Course_name,Color_name,Helpers_name,learn_to,prepare_to,practice_to,do_date,due_date,est_min,act_min,review_to,notes_to,complete) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)',[data.Course_name,val,data.Helpers_name,
        data.learn_to,data.prepare_to,data.practice_to,data.do_date,data.due_date,data.est_min,data.act_min,data.review_to,data.notes_to,data.complete]);
      return "Success";
  }

  //delete
  deleteForm(int id) async {
    final db = await database;
    return db.delete("Assign_Form", where: "id = ?", whereArgs: [id]);
  }

  //get_all order_by due date
  Future<List<form_model>> getAllform_due(String sort) async {
    final db = await database;
    print(sort);
    var res = await db.query("Assign_Form",orderBy: sort);
    List<form_model> list =  res.isNotEmpty ? res.map((c) => form_model.fromMap(c)).toList() : null;
    return list;
  }

  //get_all order_by do date
  Future<List<form_model>> getAllform_do(int comp,String date) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Assign_Form WHERE complete = ? ORDER BY ?",[comp,date]);
    List<form_model> list =
    res.isNotEmpty ? res.map((c) => form_model.fromMap(c)).toList() : null;
    return list;
  }

  //Update
  Future<String> Update_form(form_model data) async {
    final db = await database;
    var res = await db.update("Assign_Form", data.toMap(),
        where: "id = ?", whereArgs: [data.id]);
    return "Success";
  }

}