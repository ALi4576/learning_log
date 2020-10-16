import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:student_planner/Database/database_sett.dart';
import 'package:student_planner/Models/form_model.dart';

import 'Assign_Form.dart';
import 'settings.dart';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  bool dateValue = false;
  bool compValue = false;
  List<form_model> meetings = <form_model>[];
  Future event_details_due;
  //Future event_details_do;
  bool checkedValue = false;
  bool chValue = false;
  reset_state() async{
    setState(() {
      //event_details_do = DBProvider.db.getAllform_do();
      String datetype;
      int comptype;
      if(chValue == true && checkedValue == false){
        event_details_due = DBProvider.db.getAllform_due("do_date");
      }
      else if(chValue == true && checkedValue == true){
        event_details_due = DBProvider.db.getAllform_due("due_date");
      }
      else if(chValue == false && checkedValue == false){
        event_details_due = DBProvider.db.getAllform_do(1, "do_date");
      }
      else{
        event_details_due = DBProvider.db.getAllform_do(1, "due_date");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      reset_state();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Learning Log",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                    SizedBox(width: MediaQuery.of(context).size.width/20,),
                    Row(
                      children: [
                        IconButton(icon: Icon(Icons.add), onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                AssignemntForm(id: null,Course_name: "",Color_name: "",Helpers_name: "", learn_to: "", prepare_to: "", practice_to: "", do_date: 0, due_date: 0, est_min: 0, act_min: 0, review_to: "", notes_to: "")),
                          ).then((value) => {
                            reset_state()
                          });
                        }),
                        IconButton(icon: Icon(Icons.settings), onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Settings()),
                          );
                        })
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/1.8,
                      child: CheckboxListTile(
                        title: Text("Sort-Due Date",style: TextStyle(fontSize: 16.0),),
                        checkColor: Colors.white,
                        value: checkedValue,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue = newValue;
                            reset_state();
                          });
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2.3,
                      child: CheckboxListTile(
                        title: Text("Show All",style: TextStyle(fontSize: 16.0),),
                        checkColor: Colors.white,
                        value: chValue,
                        onChanged: (newValue) {
                          setState(() {
                            chValue = newValue;
                            reset_state();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Expanded(
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            FutureBuilder<List<form_model>>(
                              future: event_details_due,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 1.1,
                                    child: ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        form_model item = snapshot.data[index];
                                        DateTime d = DateTime.fromMillisecondsSinceEpoch(item.due_date);
                                        String date = d.day.toString() + "/" + d.month.toString() + "/" + d.year.toString();
                                        String dates;
                                        if(index > 0) {
                                          DateTime e = DateTime.fromMillisecondsSinceEpoch(snapshot.data[index -1].due_date);
                                          dates = e.day.toString() +
                                              "/" + e.month.toString() + "/" +
                                              e.year.toString();
                                        }
                                        return Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  if(date != dates)
                                                    Text(DateFormat('EEEE,d MMM,yyyy').format(DateTime.fromMillisecondsSinceEpoch(item.do_date)).toString(),style: TextStyle(color: Colors.grey,fontSize: 20.0,fontWeight: FontWeight.w700),),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width/1.02,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.black,width: 1),
                                                      color: Color(int.parse(item.Color_name)).withOpacity(0.5),
                                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/70,bottom: MediaQuery.of(context).size.height/70),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text("Subject:",style: TextStyle(fontSize: 16.0),),
                                                              SizedBox(height: MediaQuery.of(context).size.height/70,),
                                                              Text("Learn to:",style: TextStyle(fontSize: 16.0),),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Container(color: Colors.white, child: Text(item.Course_name,style: TextStyle(fontSize: 15.0),),),
                                                              SizedBox(height: MediaQuery.of(context).size.height/70,),
                                                              Container(
                                                                width: MediaQuery.of(context).size.width/4,
                                                                color: Colors.white,
                                                                child: Text(item.learn_to,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15.0),)
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text("Due Date:",style: TextStyle(fontSize: 16.0),),
                                                              SizedBox(height: MediaQuery.of(context).size.height/70,),
                                                              Text("Est. min:",style: TextStyle(fontSize: 16.0),),
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Container(color: Colors.white, child: Text(date,style: TextStyle(fontSize: 15.0),),),
                                                              SizedBox(height: MediaQuery.of(context).size.height/70,),
                                                              Container(color: Colors.white, child: Text(item.est_min.toString(),style: TextStyle(fontSize: 15.0),),),
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              IconButton(icon: Icon(Entypo.dots_three_vertical,size: 20.0,color: Colors.black,),
                                                                onPressed: (){
                                                                  Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(builder: (context) =>
                                                                        AssignemntForm(id:item.id,Course_name: item.Course_name,Color_name: item.Color_name,Helpers_name: item.Helpers_name, learn_to: item.learn_to,prepare_to: item.prepare_to,
                                                                          practice_to: item.practice_to, do_date: item.do_date, due_date: item.due_date, est_min: item.est_min, act_min: item.act_min, review_to: item.review_to, notes_to: item.notes_to,complete: item.complete,)),
                                                                  ).then((value) => {
                                                                    reset_state()
                                                                  });
                                                                })
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: MediaQuery.of(context).size.height/40,)
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

 /* void _showDialog(int id,String Course_name,String Color_name,String Helpers_name,String learn_to,String prepare_to,String practice_to,int do_date,int due_date,int est_min,int act_min,String review_to, String notes_to){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder: (context,setstate){
            return ButtonBarTheme(data: ButtonBarThemeData(alignment: MainAxisAlignment.center),
              child: AlertDialog(
                actions: <Widget>[
                  new FlatButton(
                    minWidth: MediaQuery.of(context).size.width,
                    child: new Text("View Details"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showDetails(id, Course_name, Color_name, Helpers_name, learn_to, prepare_to, practice_to, do_date, due_date, est_min, act_min, review_to, notes_to);
                    },
                  ),
                  new FlatButton(
                    minWidth: MediaQuery.of(context).size.width,
                    child: new Text("Edit"),
                    onPressed: () {

                    },
                  ),
                  new FlatButton(
                    minWidth: MediaQuery.of(context).size.width,
                    child: new Text("Delete"),
                    onPressed: () {
                      DBProvider.db.deleteForm(id);
                      Navigator.of(context).pop();
                      setState(() {
                        reset_state();
                      });
                    },
                  ),
                  new FlatButton(
                    minWidth: MediaQuery.of(context).size.width,
                    child: new Text("Mark as Completed"),
                    onPressed: () {
                    },
                  ),
                ],
              ),);
          });
        }
    );
  }

  void _showDetails(int id,String Course_name,String Color_name,String Helpers_name,String learn_to,String prepare_to,String practice_to,int do_date,int due_date,int est_min,int act_min,String review_to, String notes_to){
    showDialog(
        context: context,
        builder: (BuildContext context){
          DateTime does = DateTime.fromMillisecondsSinceEpoch(do_date);
          DateTime Dues = DateTime.fromMillisecondsSinceEpoch(due_date);
          return StatefulBuilder(builder: (context,setstate){
            return ButtonBarTheme(data: ButtonBarThemeData(alignment: MainAxisAlignment.center),
              child: AlertDialog(
                backgroundColor: Color(int.parse(Color_name)),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Subject: " + Course_name,style: TextStyle(fontSize: 15.0),),
                      Text("Helper Name: " + Helpers_name,style: TextStyle(fontSize: 15.0),),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Est Min: " + est_min.toString(),style: TextStyle(fontSize: 15.0),),
                      Text("Act Min: " + act_min.toString(),style: TextStyle(fontSize: 15.0),),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Do Date: " + does.day.toString() + "/" + does.month.toString() + "/" + does.year.toString() ,style: TextStyle(fontSize: 15.0),),
                      SizedBox(height: 10.0,),
                      Text("Due Date: " + Dues.day.toString() + "/" + Dues.month.toString() + "/" + Dues.year.toString(),style: TextStyle(fontSize: 15.0),),
                      SizedBox(height: 10.0,),
                      Text("Learn: " + learn_to),
                      SizedBox(height: 10.0,),
                      Text("Prepare: " + prepare_to),
                      SizedBox(height: 10.0,),
                      Text("Practice: " + practice_to),
                      SizedBox(height: 10.0,),
                      Text("Review: " + review_to),
                      SizedBox(height: 10.0,),
                      Text("Notes: " + notes_to),
                    ],
                  ),
                ],
              ),);
          });
        }
    );
  }
*/
}
