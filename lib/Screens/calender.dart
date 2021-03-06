import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:student_planner/Database/database_sett.dart';
import 'package:student_planner/Models/form_model.dart';

import 'Assign_Form.dart';
import 'settings.dart';

class Calender extends StatefulWidget {
  final String show_todo;

  const Calender({Key key, this.show_todo}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  bool dateValue = false;
  bool compValue = false;
  bool exp = false;
  String _verticalGroupValue;

  List<String> _status = ["History", "ToDo"];
  var rev = " ";
  Future event_details_due;
  Future event_details_his;
  List<String> days =[];
  bool checkedValue = false;
  bool chValue = false;
  reset_state() async{
    setState(() {
        event_details_his = DBProvider.db.showAllform_due();
        event_details_due = DBProvider.db.Todoform_do();
    });
  }

  ScrollController _controller;

  @override
  void initState() {
    _verticalGroupValue = widget.show_todo;
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    setState(() {
      reset_state();
    });
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        exp = true;
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        exp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(183, 181, 199, 1.0),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.5,
                        child: Row(
                         children: [
                           Flexible(
                             child: Text("Power Learners Calendar",style: TextStyle(
                                 fontSize: 21.0,
                                 fontWeight: FontWeight.w500),),
                           ),
                         ],
                       )
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/3.6,
                        child: Row(
                          children: [
                            IconButton(icon: Icon(Icons.add), onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    AssignemntForm(id: null,Course_name: "",Color_name: "",Helpers_name: "", learn_to: "", prepare_to: "", practice_to: "", do_date: 0, due_date: 0, est_min: 0, act_min: 0, review_1: 0, review_2: 0, notes_to: "",show_todo: _verticalGroupValue,)),
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
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: _verticalGroupValue,
                      onChanged: (value) => setState(() {
                        _verticalGroupValue = value;
                        reset_state();
                      }),
                      items: _status,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height/1.2,
                  child: Column(
                    children: [
                      (_verticalGroupValue == "ToDo") ? FutureBuilder<List<form_model>>(
                        future: event_details_due,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.22,
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  form_model item = snapshot.data[index];
                                  DateTime d = DateTime.fromMillisecondsSinceEpoch(item.sort);
                                  String date = d.month.toString() + d.day.toString() + d.year.toString();
                                  String dates;
                                  var dayu = DateTime.now();
                                  var review1date = DateTime.fromMillisecondsSinceEpoch(item.review_1);
                                  var review2date = DateTime.fromMillisecondsSinceEpoch(item.review_2);
                                  var dodate = DateTime.fromMillisecondsSinceEpoch(item.do_date);
                                  DateTime t = new DateTime(dayu.year, dayu.month, dayu.day);
                                  int tday = t.millisecondsSinceEpoch;
                                  int r1 = review1date.millisecondsSinceEpoch;
                                  int r2 = review2date.millisecondsSinceEpoch;
                                  int dd = dodate.millisecondsSinceEpoch;
                                  if(index > 0) {
                                    DateTime e = DateTime.fromMillisecondsSinceEpoch(snapshot.data[index -1].sort);
                                    dates = e.month.toString() + e.day.toString() + e.year.toString();
                                  }
                                  return Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if(index == 0)
                                          Padding(
                                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/70,left: MediaQuery.of(context).size.width/50),
                                            child: Text("Today: "+ DateFormat('EEEE, MMM d, yyyy').format(DateTime.now()).toString(),style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w700),),
                                          ),
                                        ((item.complete == 0 && dd < tday) || (item.complete == 0 && dd == tday) || (item.complete == 1 && (r1 == tday || r2 == tday))) ? Dismissible(
                                          key: Key(item.id.toString()),
                                          background: Container(color: Colors.greenAccent),
                                          onDismissed: (direction) {
                                            setState(() {
                                              snapshot.data.removeAt(index);
                                            });
                                            _showDialog(item.id,item.Course_name);
                                          },
                                          child: Display_todo_Today(tday,r1,r2,dd,date, dates, item.id, item.Course_name, item.Color_name,
                                              item.Helpers_name, item.learn_to, item.prepare_to, item.practice_to, item.do_date, item.due_date, item.est_min, item.act_min, item.review_1,
                                              item.review_2, item.notes_to, item.complete,item.sort),
                                        ) : Container(),
                                        ((item.complete == 0 && dd > tday) || (item.complete == 1 && ((r1 > tday && r2 != tday) || (r2 > tday && r1 != tday)) && (r1 != tday && r2 != tday))) ? Dismissible(
                                          key: Key(item.id.toString()),
                                          background: Container(color: Colors.greenAccent),
                                          onDismissed: (direction) {
                                            setState(() {
                                              snapshot.data.removeAt(index);
                                            });
                                            _showDialog(item.id,item.Course_name);
                                          },
                                          child: Display(date, dates, item.id, item.Course_name, item.Color_name,
                                              item.Helpers_name, item.learn_to, item.prepare_to, item.practice_to, item.do_date, item.due_date, item.est_min, item.act_min, item.review_1,
                                              item.review_2, item.notes_to, item.complete ,item.sort),
                                        ) : Container(),
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
                      ) : Container(),
                      (_verticalGroupValue == "History") ? FutureBuilder<List<form_model>>(
                        future: event_details_his,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            snapshot.data.sort((a,b) => a.due_date.compareTo(b.due_date));
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.22,
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  form_model item = snapshot.data[index];
                                  DateTime d = DateTime.fromMillisecondsSinceEpoch(item.due_date);
                                  String date = d.month.toString() + "/" + d.day.toString() + "/" + d.year.toString();
                                  String dates;
                                  var dayu = DateTime.now();
                                  var review1date = DateTime.fromMillisecondsSinceEpoch(item.review_1);
                                  var review2date = DateTime.fromMillisecondsSinceEpoch(item.review_2);
                                  var dodate = DateTime.fromMillisecondsSinceEpoch(item.do_date);
                                  var t = DateTime(dayu.year,dayu.month,dayu.day);
                                  int tday = t.millisecondsSinceEpoch;
                                  int r1 = review1date.millisecondsSinceEpoch;
                                  int r2 = review2date.millisecondsSinceEpoch;
                                  int dd = dodate.millisecondsSinceEpoch;
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
                                        ((item.complete == 1 && dd >= tday && (r1 < tday && r2 < tday)) || (item.complete == 1 && dd > tday && (r1 == 197011 && r2 == 197011)) || (item.complete == 1 && dd == tday && (r1 == 197011  && r2 == 197011 )) || (r1 < tday && r2 < tday && dd < tday) && ((item.complete == 1 && dd < tday) || (item.complete == 1 && dd < tday && r1 == 0 && r2 ==0) || (item.complete == 1 && (r1 < tday && r2 < tday)))) ? Dismissible(
                                          key: Key(item.id.toString()),
                                          background: Container(color: Colors.greenAccent),
                                          onDismissed: (direction) {
                                            setState(() {
                                              snapshot.data.removeAt(index);
                                            });
                                            _showDialog(item.id,item.Course_name);
                                          },
                                          child: Display_show_all(tday,r1,r2,dd,date, dates, item.id, item.Course_name, item.Color_name,
                                              item.Helpers_name, item.learn_to, item.prepare_to, item.practice_to, item.do_date, item.due_date, item.est_min, item.act_min, item.review_1,
                                              item.review_2, item.notes_to, item.complete),
                                        ) : Container(height: 0.0,),
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
                      ) : Container(),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Widget Display_show_all(int tday,int r1,int r2,int dd,String date, String dates, int id, String Course_name, String Color_name, String Helpers_name, String learn_to,String prepare_to,String practice_to,int do_date,int due_date,int est_min,int act_min,int review_1,int review_2,String notes_to, int complete){
    DateTime e = DateTime.fromMillisecondsSinceEpoch(due_date);
    var duesdates = e.month.toString() +
        "/" + e.day.toString() + "/" +
        e.year.toString();

    Color backcolor = Colors.white;
    Color bordercolor = Colors.black;
    var width = 1.0;


    if(((r1 > 0 || r2 > 0) && ((r1 == tday && complete == 1) || (r2 == tday && complete == 1)))){
      backcolor = Color.fromRGBO(216, 215, 225, 1.0);
    }
    else if(complete == 1 && ((dd < tday && (r1 < tday && r2 < tday)))){
      backcolor = Color.fromRGBO(216, 215, 225, 1.0);
    }
    else if(dd == tday && complete == 1){
      backcolor = Color.fromRGBO(216, 215, 225, 1.0);
    }
    else if((complete == 1 && dd >= tday && (r1 < tday && r2 < tday)) || (complete == 1 && dd > tday && (r1 == 197011 && r2 == 197011))){
      backcolor = Color.fromRGBO(216, 215, 225, 1.0);
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(duesdates != dates)
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/70,left: MediaQuery.of(context).size.width/50),
              child: Text(DateFormat('EEEE, MMM d, yyyy').format(DateTime.fromMillisecondsSinceEpoch(due_date)).toString(),style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w700),),
            ),
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width/1.02,
              decoration: BoxDecoration(
                  border: Border.all(color:bordercolor,width: width),
                  color: backcolor,
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
                            color: Color(int.parse(Color_name)),
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Center(child: Text(Course_name,style: TextStyle(fontSize: 20.0),)),),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: MediaQuery.of(context).size.height/25,
                        child: Center(child: Text("Due " + duesdates.toString(),style: TextStyle(fontSize: 20.0),)),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width/30,),
                      Container(
                        width: MediaQuery.of(context).size.width/12,
                        height: MediaQuery.of(context).size.height/30,
                        child: Center(
                          child: (complete == 1) ? Container(
                            height: MediaQuery.of(context).size.height/40,
                            width: MediaQuery.of(context).size.width/6,
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: true,
                              onChanged: (newValue) {
                              },
                            ),
                          ) : Container(
                            height: MediaQuery.of(context).size.height/40,
                            width: MediaQuery.of(context).size.width/6,
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: false,
                              onChanged: (newValue) {
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/90,left: MediaQuery.of(context).size.width/30,),
                        child: Container(
                            width: MediaQuery.of(context).size.width/1.25,
                            height: MediaQuery.of(context).size.height/25,
                            child: Text(learn_to,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18.0),)
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width/50,),
                      Text(est_min.toString())
                    ],
                  ),
                ],
              ),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    AssignemntForm(id: id,Course_name: Course_name,Color_name: Color_name,Helpers_name:Helpers_name,
                      learn_to: learn_to, prepare_to: prepare_to, practice_to: practice_to, do_date: do_date, due_date: due_date,
                      est_min: est_min, act_min: act_min, review_1: review_1,review_2: review_2, notes_to: notes_to,complete: complete,show_todo: _verticalGroupValue,)),
              ).then((value) => {
                reset_state()
              });
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height/40,),
        ],
      ),
    );
  }

  Widget Display_todo_Today(int tday,int r1,int r2,int dd,String date, String dates, int id, String Course_name, String Color_name, String Helpers_name, String learn_to,String prepare_to,String practice_to,int do_date,int due_date,int est_min,int act_min,int review_1,int review_2,String notes_to, int complete,int sort){
    DateTime e = DateTime.fromMillisecondsSinceEpoch(due_date);
    var duesdates = e.month.toString() +
        "/" + e.day.toString() + "/" +
        e.year.toString();
    Color backcolor = Colors.white;
    Color bordercolor = Colors.black;
    var width = 1.0;
    if(dd < tday && complete == 0){
        backcolor = Colors.white;
        bordercolor = Colors.red;
        width = 3.0;
    }
    else if(dd == tday && complete == 0){
        backcolor = Colors.white;
        bordercolor = Colors.black;
    }
    else if(((r1 > 0 || r2 > 0) && ((r1 == tday && complete == 1) || (r2 == tday && complete == 1)))){
        backcolor = Color.fromRGBO(216, 215, 225, 1.0);
        bordercolor = Colors.black;
    }

    DateTime de = DateTime.now();
    var dat = de.month.toString() +
        "/" + de.day.toString() + "/" +
        de.year.toString();

    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width/1.02,
                decoration: BoxDecoration(
                    border: Border.all(color: bordercolor,width: width),
                    color: backcolor,
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
                              color: Color(int.parse(Color_name)),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Center(child: Text(Course_name,style: TextStyle(fontSize: 20.0),)),),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          height: MediaQuery.of(context).size.height/25,
                          child: Center(child: Text("Due " + duesdates.toString(),style: TextStyle(fontSize: 20.0),)),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/30,),
                        Container(
                          width: MediaQuery.of(context).size.width/12,
                          height: MediaQuery.of(context).size.height/30,
                          child: Center(
                            child: (complete == 1 && (review_1 > 0  || review_2 > 0)) ? Container(
                              height: MediaQuery.of(context).size.height/40,
                              width: MediaQuery.of(context).size.width/6,
                              child: Checkbox(
                                checkColor: Colors.white,
                                value: true,
                                onChanged: (newValue) {
                                },
                              ),
                            ) : Container(
                              height: MediaQuery.of(context).size.height/40,
                              width: MediaQuery.of(context).size.width/6,
                              child: Checkbox(
                                checkColor: Colors.white,
                                value: false,
                                onChanged: (newValue) {
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/90,left: MediaQuery.of(context).size.width/30,),
                          child: Container(
                              width: MediaQuery.of(context).size.width/1.25,
                              height: MediaQuery.of(context).size.height/25,
                              child: Text(learn_to,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18.0),)
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/50,),
                        Text(est_min.toString())
                      ],
                    ),
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      AssignemntForm(id: id,Course_name: Course_name,Color_name: Color_name,Helpers_name:Helpers_name,
                        learn_to: learn_to, prepare_to: prepare_to, practice_to: practice_to, do_date: do_date, due_date: due_date,
                        est_min: est_min, act_min: act_min, review_1: review_1,review_2: review_2, notes_to: notes_to,complete: complete,show_todo: _verticalGroupValue,)),
                ).then((value) => {
                  reset_state()
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height/40,),
          ],
        ),
      ),
    );
  }

  Widget Display(String date, String dates, int id, String Course_name, String Color_name, String Helpers_name, String learn_to,String prepare_to,String practice_to,int do_date,
      int due_date,int est_min,int act_min,int review_1,int review_2,String notes_to, int complete,int sort){
    DateTime e = DateTime.fromMillisecondsSinceEpoch(due_date);
    var duesdates = e.month.toString() +
        "/" + e.day.toString() + "/" +
        e.year.toString();
    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(date != dates)
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/70,left: MediaQuery.of(context).size.width/50),
                child: Text(DateFormat('EEEE, MMM d, yyyy').format(DateTime.fromMillisecondsSinceEpoch(sort)).toString(),style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w700),),
              ),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width/1.02,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 1),
                    color: (complete == 0) ? (Colors.white) : (Color.fromRGBO(216, 215, 225, 1.0)),
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
                              color: Color(int.parse(Color_name)),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Center(child: Text(Course_name,style: TextStyle(fontSize: 20.0),)),),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          height: MediaQuery.of(context).size.height/25,
                          child: Center(child: Text("Due " + duesdates.toString(),style: TextStyle(fontSize: 20.0),)),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/30,),
                        Container(
                          width: MediaQuery.of(context).size.width/12,
                          height: MediaQuery.of(context).size.height/30,
                          child: Center(
                            child: (complete == 1 && (review_1 > 0  || review_2 > 0)) ? Container(
                              height: MediaQuery.of(context).size.height/40,
                              width: MediaQuery.of(context).size.width/6,
                              child: Checkbox(
                                checkColor: Colors.white,
                                value: true,
                                onChanged: (newValue) {
                                },
                              ),
                            ) : Container(
                              height: MediaQuery.of(context).size.height/40,
                              width: MediaQuery.of(context).size.width/6,
                              child: Checkbox(
                                checkColor: Colors.white,
                                value: false,
                                onChanged: (newValue) {
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/90,left: MediaQuery.of(context).size.width/30,),
                          child: Container(
                              width: MediaQuery.of(context).size.width/1.25,
                              height: MediaQuery.of(context).size.height/25,
                              child: Text(learn_to,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18.0),)
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/50,),
                        Text(est_min.toString())
                      ],
                    ),
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      AssignemntForm(id: id,Course_name: Course_name,Color_name: Color_name,Helpers_name:Helpers_name,
                        learn_to: learn_to, prepare_to: prepare_to, practice_to: practice_to, do_date: do_date, due_date: due_date,
                        est_min: est_min, act_min: act_min, review_1: review_1,review_2: review_2, notes_to: notes_to,complete: complete,show_todo: _verticalGroupValue,)),
                ).then((value) => {
                  reset_state()
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height/40,),
          ],
        ),
      ),
    );
  }

  void _showDialog(int id,String name){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (context,setState){
                return AlertDialog(
                  title: new Text("Delete"),
                  content: new Text("Delete $name Asssignment?"),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("Yes"),
                      onPressed: () {
                        DBProvider.db.deleteForm(id).then((value) => {
                          reset_state()
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    new FlatButton(
                      child: new Text("No"),
                      onPressed: () {
                        reset_state();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );}
          );
        }
    );
  }
}
