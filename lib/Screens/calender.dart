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
          color: Color.fromRGBO(183, 181, 199, 1.0),
          child: Padding(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/20),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
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
                            ).then((value) => {
                              reset_state()
                            });
                          })
                        ],
                      )
                    ],
                  ),
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
                                        String date = d.month.toString() + "/" + d.day.toString() + "/" + d.year.toString();
                                        String dates;
                                        if(index > 0) {
                                          DateTime e = DateTime.fromMillisecondsSinceEpoch(snapshot.data[index -1].due_date);
                                          dates = e.month.toString() +
                                              "/" + e.day.toString() + "/" +
                                              e.year.toString();
                                        }
                                        return Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if(date != dates)
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 8.0),
                                                      child: Text(DateFormat('EEEE, d MMM, yyyy').format(DateTime.fromMillisecondsSinceEpoch(item.do_date)).toString(),style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w700),),
                                                    ),
                                                  GestureDetector(
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width/1.02,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black,width: 1),
                                                        color: (item.complete == 0) ? (Colors.white) : (Color.fromRGBO(216, 215, 225, 1.0)),
                                                        borderRadius: BorderRadius.all(Radius.circular(15))
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(context).size.width/3.5,
                                                                height: MediaQuery.of(context).size.height/25,
                                                                decoration: BoxDecoration(
                                                                    color: Color(int.parse(item.Color_name)),
                                                                    borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                child: Center(child: Text(item.Course_name,style: TextStyle(fontSize: 20.0),)),),
                                                              Container(
                                                                width: MediaQuery.of(context).size.width/2,
                                                                height: MediaQuery.of(context).size.height/25,
                                                                child: Center(child: Text("Due " + date,style: TextStyle(fontSize: 20.0),)),
                                                              ),
                                                              SizedBox(width: MediaQuery.of(context).size.width/30,),
                                                              Container(
                                                                width: MediaQuery.of(context).size.width/12,
                                                                height: MediaQuery.of(context).size.height/30,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                    child: (item.complete == 1) ? Text("X",style: TextStyle(fontSize: 20.0),) : Text(" ",style: TextStyle(fontSize: 20.0),),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/90,left: MediaQuery.of(context).size.width/30,),
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width/2,
                                                              height: MediaQuery.of(context).size.height/25,
                                                              child: Text(item.learn_to,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18.0),)
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) =>
                                                            AssignemntForm(id: item.id,Course_name: item.Course_name,Color_name: item.Color_name,Helpers_name: item.Helpers_name,
                                                                learn_to: item.learn_to, prepare_to: item.prepare_to, practice_to: item.practice_to, do_date: item.do_date, due_date: item.due_date,
                                                                est_min: item.est_min, act_min: item.act_min, review_to: item.review_to, notes_to: item.notes_to,complete: item.complete,)),
                                                      ).then((value) => {
                                                        reset_state()
                                                      });
                                                    },
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
}
