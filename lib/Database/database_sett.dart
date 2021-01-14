import 'dart:async';
import 'dart:io';
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

  static Future<void> _createDb(Database db) async {
     db.execute('CREATE TABLE Settings (id INTEGER PRIMARY KEY,Course_name TEXT,Color_name TEXT)');
     db.execute('CREATE TABLE Helpers (id INTEGER PRIMARY KEY,Helper_name TEXT)');
     db.execute('CREATE TABLE Assign_Form (id INTEGER PRIMARY KEY AUTOINCREMENT,Course_name TEXT,Color_name TEXT,Helpers_name TEXT,learn_to TEXT,prepare_to TEXT,practice_to TEXT,do_date INTEGER,due_date INTEGER,est_min INTEGER,act_min INTEGER,review_1 INTEGER,review_2 INTEGER,notes_to TEXT,complete INTEGER)');
     var batch = db.batch();
     List<String> Courses = new List(10);
     Courses[0] = "0xFFFF6166";
     Courses[1] = "0xFFFF9966";
     Courses[2] = "0xFFFFCC66";
     Courses[3] = "0xFFFFFF99";
     Courses[4] = "0xFFC3FD9B";
     Courses[5] = "0xFF66DC82";
     Courses[6] = "0xFF70F4DE";
     Courses[7] = "0xFF79CDEF";
     Courses[8] = "0xFF88B1CA";
     Courses[9] = "0xFFB7B7FF";
     List<String> Courses1 = new List(10);
     Courses1[0] = "Algebra";
     Courses1[1] = "English";
     Courses1[2] = "Geography";
     Courses1[3] = "Chemistry";
     Courses1[4] = "History";
     Courses1[5] = "Music";
     Courses1[6] = "Spanish";
     Courses1[7] = "Biology";
     Courses1[8] = "";
     Courses1[9] = "";
     Settings_Stu st = new Settings_Stu();
     for(int i = 0;i < 10;i++){
       st.id = i + 1;
       st.Course_name = Courses1[i];
       st.Color_name = Courses[i];
       batch.insert('Settings', st.toMap());
     }
     List<String> Helperslist = new List(10);
     Helperslist[0] = "Bob";
     Helperslist[1] = "Alice";
     Helperslist[2] = "Ms.Franklin";
     Helperslist[3] = "Aunt Ellen";
     Helperslist[4] = "";
     Helperslist[5] = "";
     Helperslist[6] = "";
     Helperslist[7] = "";
     Helperslist[8] = "";
     Helperslist[9] = "";
     Help_Stu ht = new Help_Stu();
     for(int i = 1;i <= 10;i++){
       ht.id = i;
       ht.Helper_name = Helperslist[i - 1];
       batch.insert('Helpers', ht.toMap());
     }
     await batch.commit();
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

  //Update
  Future<String> Update_set(Settings_Stu data) async {
    final db = await database;
    var res = await db.update("Settings", data.toMap(),
        where: "id = ?", whereArgs: [data.id]);
    return "Success";
  }

  //Get All courses
  Future<List<Settings_Stu>> getAllSettings() async {
    final db = await database;
    var res = await db.query("Settings");
    List<Settings_Stu> list = res.isNotEmpty ? res.map((c) => Settings_Stu.fromMap(c)).toList() : null;
    List<Settings_Stu> sort = <Settings_Stu>[];
    for(int i = 0;i < list.length;i++){
      if(list[i].Course_name != ""){
        Settings_Stu st = new Settings_Stu();
        st.id = list[i].id;
        st.Course_name = list[i].Course_name;
        st.Color_name = list[i].Color_name;
        sort.add(st);
      }
    }
    return sort;
  }

  Future<List<Settings_Stu>> getset() async {
    final db = await database;
    var res = await db.query("Settings");
    List<Settings_Stu> list = res.isNotEmpty ? res.map((c) => Settings_Stu.fromMap(c)).toList() : null;
    return list;
  }

//delete all
  Future<String> deleteall() async {
    final db = await database;
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

  //Update
  Future<String> Update_help(Help_Stu data) async {
    final db = await database;
    var res = await db.update("Helpers", data.toMap(),
        where: "id = ?", whereArgs: [data.id]);
    return "Success";
  }

  //Get ALl Helpers
  Future<List<Help_Stu>> getAllHelp() async {
    final db = await database;
    var res = await db.query("Helpers");
    List<Help_Stu> list = res.isNotEmpty ? res.map((c) => Help_Stu.fromMap(c)).toList() : null;
    List<Help_Stu> sort = <Help_Stu>[];
    for(int i = 0;i < list.length;i++){
      if(list[i].Helper_name != ""){
        Help_Stu st = new Help_Stu();
        st.id = list[i].id;
        st.Helper_name = list[i].Helper_name;
        sort.add(st);
      }
    }
    return sort;
  }

  Future<List<Help_Stu>> getHelp() async {
    final db = await database;
    var res = await db.query("Helpers");
    List<Help_Stu> list = res.isNotEmpty ? res.map((c) => Help_Stu.fromMap(c)).toList() : null;
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

  //show_all
  Future<List<form_model>> showAllform_due() async {
    final db = await database;
    var res = await db.query("Assign_Form");
    List<form_model> list =  res.isNotEmpty ? res.map((c) => form_model.fromMap(c)).toList() : null;
    List<form_model> sorting = <form_model>[];
    if(list != null){
      for(int i = 0;i<list.length;i++){
        var dayu = DateTime.now();
        var review1date = DateTime.fromMillisecondsSinceEpoch(list[i].review_1);
        var review2date = DateTime.fromMillisecondsSinceEpoch(list[i].review_2);
        var dodate = DateTime.fromMillisecondsSinceEpoch(list[i].do_date);
        var t = DateTime(dayu.year,dayu.month,dayu.day);
        int tday = t.millisecondsSinceEpoch;
        int r1 = review1date.millisecondsSinceEpoch;
        int r2 = review2date.millisecondsSinceEpoch;
        int dd = dodate.millisecondsSinceEpoch;
        if((list[i].complete == 1 && dd >= tday && (r1 < tday && r2 < tday)) || (list[i].complete == 1 && dd > tday && (r1 == 0 && r2 == 0)) || (list[i].complete == 1 && dd == tday && (r1 == 0 && r2 == 0)) ||(list[i].complete == 1 && dd < tday) || (list[i].complete == 1 && dd < tday && r1 == 0 && r2 ==0) || (list[i].complete == 1 && (r1 < tday && r2 < tday))){
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
          fm.sort = list[i].due_date;
          sorting.add(fm);
        }
      }
      sorting.sort((a,b) => a.due_date.compareTo(b.due_date));
      return sorting;
    }
    else{
      return null;
    }
  }

  //Todo
  Future<List<form_model>> Todoform_do() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Assign_Form WHERE (review_1 IS NOT NULL AND complete = 1) OR (review_2 IS NOT NULL AND complete = 1)  OR (complete = 0) ORDER BY "
        "(CASE WHEN review_1 IS NOT NULL THEN review_1 WHEN review_2 IS NOT NULL THEN review_2 ELSE do_date END)");
    List<form_model> list =
    res.isNotEmpty ? res.map((c) => form_model.fromMap(c)).toList() : null;
    List<form_model> sorting = <form_model>[];
    if(list != null){
      for(int i = 0;i<list.length;i++){
        var dayu = DateTime.now();
        var review1date = DateTime.fromMillisecondsSinceEpoch(list[i].review_1);
        var review2date = DateTime.fromMillisecondsSinceEpoch(list[i].review_2);
        var dodate = DateTime.fromMillisecondsSinceEpoch(list[i].do_date);
        var t = DateTime(dayu.year,dayu.month,dayu.day);
        int tday = t.millisecondsSinceEpoch;
        int r1 = review1date.millisecondsSinceEpoch;
        int r2 = review2date.millisecondsSinceEpoch;
        int dd = dodate.millisecondsSinceEpoch;
        if(list[i].complete == 0 && dd >= tday){
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
          //print(DateTime.fromMillisecondsSinceEpoch(fm.sort));
          fm.Helpers_name = list[i].Helpers_name;
          sorting.add(fm);
        }
        else if(list[i].complete == 0 && dd < tday){
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
          //print(DateTime.fromMillisecondsSinceEpoch(fm.sort));
          fm.Helpers_name = list[i].Helpers_name;
          sorting.add(fm);
        }
        else if (list[i].complete == 1 && r1 < tday && r2 < tday){
          form_model fm = new form_model();
          if(list[i].review_1 > list[i].review_2){
            fm.sort = list[i].review_1;
          }
          else{
            fm.sort = list[i].review_2;
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
          //fm.sort = list[i].do_date;
          fm.Helpers_name = list[i].Helpers_name;
          //print(DateTime.fromMillisecondsSinceEpoch(fm.sort));
          sorting.add(fm);
        }
        else if(list[i].complete == 1 && (r1 >= tday && r2 >= tday)){
          form_model fm = new form_model();
          if(list[i].review_1 >= list[i].review_2){
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
          //print(DateTime.fromMillisecondsSinceEpoch(fm.sort));
          sorting.add(fm);
        }
        else if(list[i].complete == 1 && (r1 >= tday || r2 >= tday) || list[i].complete == 0){
          form_model fm = new form_model();
          if(list[i].review_1 >= DateTime.now().millisecondsSinceEpoch){
            fm.sort = list[i].review_1;
          }
          else{
            fm.sort = list[i].review_2;
          }
          fm.complete = 1;
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
        else if(list[i].complete == 1 && (r1 > 0 || r2 > 0) && (r1 < tday || r2 < tday)){
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
    }
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