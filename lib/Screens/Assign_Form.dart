import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:student_planner/Database/database_sett.dart';
import 'package:student_planner/Models/form_model.dart';
import 'package:student_planner/Models/settingsModel.dart';

import 'calender.dart';

class AssignemntForm extends StatefulWidget {
  final int id;
  final String Course_name;
  final String Color_name;
  final String Helpers_name;
  final String learn_to;
  final String prepare_to;
  final String practice_to;
  final int do_date;
  final int due_date;
  final int est_min;
  final int act_min;
  final String review_to;
  final String notes_to;
  final int complete;

  const AssignemntForm({Key key, this.id, this.Course_name, this.Helpers_name, this.learn_to, this.prepare_to, this.practice_to, this.do_date, this.due_date, this.est_min, this.act_min, this.review_to, this.notes_to, this.Color_name, this.complete}) : super(key: key);


  @override
  _AssignemntFormState createState() => _AssignemntFormState();
}

class _AssignemntFormState extends State<AssignemntForm> {
  final subjectController = TextEditingController();
  final colorController = TextEditingController();
  final dateController = TextEditingController();
  final learnController = TextEditingController();
  final doController = TextEditingController();
  final helpController = TextEditingController();
  final estminController = TextEditingController();
  final actminController = TextEditingController();
  final notesController = TextEditingController();
  final compController = TextEditingController();

  int due_val = 0;
  int do_val = 0;

  String _dodate = " ";
  String _duedate = " ";
  List _myPreparation;
  List _myPractices;
  List _review;
  List<Settings_Stu> _subjects = <Settings_Stu>[];
  Settings_Stu _dropdownValue;
  List<Help_Stu> _helpers = <Help_Stu>[];
  Help_Stu _dropHelpValue;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool sub= true,hel= true,learn= true,prep= true,prac= true,dod= true,due= true,est= true,act= true,review = true,complete = false;

  Future courselist() async {
    _subjects = await DBProvider.db.getAllSettings();
    _helpers = await DBProvider.db.getAllHelp();
    setState(() {
      if(widget.id == null){
        if(_subjects != null){
          _dropdownValue = _subjects[0];
          subjectController.text = _subjects[0].Course_name;
          colorController.text = _subjects[0].Color_name;
        }
        if(_helpers != null){
          _dropHelpValue = _helpers[0];
          helpController.text = _helpers[0].Helper_name;
        }
        due_val = 0;
        do_val = 0;
        _dodate = " ";
        _duedate = " ";
      }
      else{
        int j = 0;
        print(_subjects.length);
        print(widget.id);
        if(_subjects != null){
          for(int i = 0;i<_subjects.length;i++){
            if(_subjects[i].Course_name == widget.Course_name){
              setState(() {
                j = i;
              });
              break;
            }
          }
          _dropdownValue = _subjects[j];
          subjectController.text = _subjects[j].Course_name;
          colorController.text = _subjects[j].Color_name;
        }
        if(_helpers != null){
          int k = 0;
          for(int i = 0;i<_helpers.length;i++){
            if(_helpers[i].Helper_name == widget.Helpers_name){
              setState(() {
                k = i;
              });
              break;
            }
          }
          _dropHelpValue = _helpers[k];
          helpController.text = _helpers[k].Helper_name;
        }
        if(widget.complete == 0){
          compController.text = 0.toString();
          complete = false;
        }
        else{
          compController.text = 1.toString();
          complete = true;
        }
        due_val = widget.due_date;
        var a = DateTime.fromMillisecondsSinceEpoch(due_val);
        _duedate = '${a.day}/${a.month}/${a.year}';
        do_val = widget.do_date;
        var b = DateTime.fromMillisecondsSinceEpoch(do_val);
        _dodate = '${b.day}/${b.month}/${b.year}';
        learnController.text = widget.learn_to;
        notesController.text = widget.notes_to;
        actminController.text = widget.act_min.toString();
        estminController.text = widget.est_min.toString();
        colorController.text = widget.Color_name;
        compController.text = widget.complete.toString();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if(widget.id != null){
      _myPreparation = widget.prepare_to.split(",").toList();
      _myPractices = widget.practice_to.split(",").toList();
      _review = widget.review_to.split(",").toList();
    }
    else{
      _myPreparation = [];
      _myPractices = [];
      _review = [];
    }
    setState(() {
      courselist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Color.fromRGBO(183, 181, 199, 1.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/70.0,left:MediaQuery.of(context).size.width/22.0,right:MediaQuery.of(context).size.width/22.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(icon: Icon(Icons.keyboard_backspace),color: Colors.white, onPressed: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Calender()));
                  }),
                  Text("Assignment Details",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w500),)
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Subject",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                      Container(
                        width: MediaQuery.of(context).size.width/2.3,
                        child: FormField(
                          builder: (FormFieldState state) {
                            return DropdownButtonHideUnderline(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  new InputDecorator(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(2.0),
                                        ),
                                        fillColor: (_dropdownValue != null) ? Color(int.parse(_dropdownValue.Color_name)) : Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(2.0),
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(252, 228, 219, 200.0),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                                        enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                                            borderSide: BorderSide(color: Color.fromRGBO(252, 228, 219, 200.0), width: 3.0))
                                    ),
                                    isEmpty: subjectController == null,
                                    child: new DropdownButton<Settings_Stu>(
                                      value: _dropdownValue,
                                      isDense: true,
                                      onChanged: (Settings_Stu newValue) {
                                        setState(() {
                                          if(newValue.Course_name != null || newValue.Course_name != ""){
                                            subjectController.text = newValue.Course_name;
                                            colorController.text = newValue.Color_name;
                                            print(colorController.text);
                                            _dropdownValue = newValue;
                                          }
                                        });
                                      },
                                      items: (_dropdownValue != null) ? _subjects.map((Settings_Stu value) {
                                        return DropdownMenuItem<Settings_Stu>(
                                          value: value,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width/4,
                                            child: Row(
                                              children: [
                                                Expanded(child: Text(value.Course_name,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18.0),)),
                                              ],
                                            ),
                                          )
                                        );
                                      }).toList() : null
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      if(sub == false)
                        Text("Required",style: TextStyle(color: Colors.red),)
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/20.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Helpers",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                      Container(
                        width: MediaQuery.of(context).size.width/2.4,
                        child: FormField(
                          builder: (FormFieldState state) {
                            return DropdownButtonHideUnderline(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  new InputDecorator(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(2.0),
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(2.0),
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(252, 228, 219, 200.0),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                                        enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                                            borderSide: BorderSide(color: Color.fromRGBO(252, 228, 219, 200.0), width: 3.0))
                                    ),
                                    isEmpty: helpController == null,
                                    child: new DropdownButton<Help_Stu>(
                                        value: _dropHelpValue,
                                        isDense: true,
                                        onChanged: (Help_Stu newValue) {
                                          setState(() {
                                            if(newValue.Helper_name != null || newValue.Helper_name != ""){
                                              helpController.text = newValue.Helper_name;
                                              _dropHelpValue = newValue;
                                            }
                                          });
                                        },
                                        items: (_dropHelpValue != null) ? _helpers.map((Help_Stu value) {
                                          return DropdownMenuItem<Help_Stu>(
                                            value: value,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width/4,
                                              child: Row(
                                                children: [
                                                  Expanded(child: Text(value.Helper_name,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18.0),)),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList() : null
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      if(hel == false)
                        Text("Required",style: TextStyle(color: Colors.red),)
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Learn To:",style: TextStyle(color: Colors.white,fontSize: 18.0)),
                      Container(
                        height: MediaQuery.of(context).size.height/25,
                        width: MediaQuery.of(context).size.width/1.11,
                        child: TextField(
                          controller: learnController,
                          style: TextStyle(fontSize: 20.0),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(252, 228, 219, 200.0),
                                ),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                              enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                                  borderSide: BorderSide(color: Color.fromRGBO(252, 228, 219, 200.0), width: 3.0))
                          ),
                        ),
                      ),
                      if(learn == false)
                        Text("Required",style: TextStyle(color: Colors.red),)
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Prepare",style: TextStyle(color: Colors.white,fontSize: 18.0)),
                      Container(
                        height: (_myPreparation == []) ? MediaQuery.of(context).size.height/40 : MediaQuery.of(context).size.height/8.8,
                        width: MediaQuery.of(context).size.width/1.11,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            MultiSelectFormField(
                              autovalidate: false,
                              title: Container(),
                              chipBackGroundColor: Color.fromRGBO(255, 97, 102, 1.0),
                              chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                              checkBoxActiveColor: Colors.red,
                              checkBoxCheckColor: Colors.white,
                              dialogTextStyle: TextStyle(fontSize: 22.0),
                              dialogShapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
                              dataSource: [
                                {
                                  "display": "Class",
                                  "value": "Class",
                                },
                                {
                                  "display": "List",
                                  "value": "List",
                                },
                                {
                                  "display": "Read",
                                  "value": "Read",
                                },
                                {
                                  "display": "Video",
                                  "value": "Video",
                                },
                                {
                                  "display": "Demo",
                                  "value": "Demo",
                                },
                                {
                                  "display": "Discuss",
                                  "value": "Discuss",
                                },
                                {
                                  "display": "Summarize",
                                  "value": "Summarize",
                                },
                                {
                                  "display": "Draw Diagram",
                                  "value": "Draw Diagram",
                                },
                                {
                                  "display": "Flashcards",
                                  "value": "Flashcards",
                                },
                                {
                                  "display": "Outline",
                                  "value": "Outline",
                                },
                              ],
                              hintWidget: Text("Select one or more entries from dropdown list "),
                              textField: 'display',
                              valueField: 'value',
                              okButtonLabel: 'OK',
                              cancelButtonLabel: 'CANCEL',
                              initialValue: _myPreparation,
                              onSaved: (value) {
                                if (value == null) return null;
                                setState(() {
                                  _myPreparation = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      if(prep == false)
                        Text("Required",style: TextStyle(color: Colors.red),)
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Practice",style: TextStyle(color: Colors.white,fontSize: 18.0)),
                      Container(
                        height: (_myPractices == []) ? MediaQuery.of(context).size.height/25 : MediaQuery.of(context).size.height/8.8,
                        width: MediaQuery.of(context).size.width/1.11,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            MultiSelectFormField(
                              autovalidate: false,
                              chipBackGroundColor: Color.fromRGBO(255, 255, 153, 1.0),
                              dialogTextStyle: TextStyle(fontSize: 20.0),
                              chipLabelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                              checkBoxActiveColor: Colors.yellow,
                              checkBoxCheckColor: Colors.white,
                              dialogShapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
                              dataSource: [
                                {
                                  "display": "Answer Orally",
                                  "value": "Answer Orally",
                                },
                                {
                                  "display": "Short answers",
                                  "value": "Short answers",
                                },
                                {
                                  "display": "Essay answers",
                                  "value": "Essay answers",
                                },
                                {
                                  "display": "Solve problems",
                                  "value": "Solve problems",
                                },
                                {
                                  "display": "Memorize",
                                  "value": "Memorize",
                                },
                                {
                                  "display": "Flashcard drill",
                                  "value": "Flashcard drill",
                                },
                                {
                                  "display": "Write essay or paper",
                                  "value": "Write essay or paper",
                                },
                                {
                                  "display": "Describe or discuss",
                                  "value": "Describe or discuss",
                                },
                                {
                                  "display": "Write new language",
                                  "value": "Write new language",
                                },
                                {
                                  "display": "Read new language",
                                  "value": "Read new language",
                                },
                                {
                                  "display": "Speak new language",
                                  "value": "Speak new language",
                                },
                                {
                                  "display": "Listen new language",
                                  "value": "Listen new language",
                                },
                              ],
                              hintWidget: Text("Select one or more entries from dropdown list "),
                              title: Container(height: 0.0,width: 0.0,),
                              textField: 'display',
                              valueField: 'value',
                              okButtonLabel: 'OK',
                              cancelButtonLabel: 'CANCEL',
                              initialValue: _myPractices,
                              onSaved: (value) {
                                if (value == null) return;
                                setState(() {
                                  _myPractices = value;
                                  print(_myPractices);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      if(prac == false)
                        Text("Required",style: TextStyle(color: Colors.red),)
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Do Date",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                      GestureDetector(
                        child: Container(
                          height: MediaQuery.of(context).size.height/25,
                          width: MediaQuery.of(context).size.width/2.3,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(_dodate,style: TextStyle(fontSize: 18.0),),
                              IconButton(icon: Icon(Icons.calendar_today_outlined,size: 18.0,), onPressed: (){
                                DatePicker.showDatePicker(context,
                                    theme: DatePickerTheme(
                                      containerHeight: 210.0,
                                    ),
                                    showTitleActions: true,
                                    minTime: DateTime(2000, 1, 1),
                                    maxTime: DateTime(2100, 12, 31), onConfirm: (date) {
                                      int i = date.millisecondsSinceEpoch;
                                      _dodate = '${date.day}/${date.month}/${date.year}';
                                      setState(() {
                                        doController.text = _dodate;
                                        do_val = i;
                                      });
                                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                              })
                            ],
                          ),
                        ),
                        onTap: (){
                          DatePicker.showDatePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true,
                              minTime: DateTime(2000, 1, 1),
                              maxTime: DateTime(2100, 12, 31), onConfirm: (date) {
                                print(date);
                                int i = date.millisecondsSinceEpoch;
                                _dodate = '${date.day}/${date.month}/${date.year}';
                                setState(() {
                                  doController.text = _dodate;
                                  do_val = i;
                                });
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                      ),
                      if(dod == false)
                        Text("Required",style: TextStyle(color: Colors.red),)
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/20.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Due Date",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                      GestureDetector(
                        child: Container(
                          height: MediaQuery.of(context).size.height/25,
                          width: MediaQuery.of(context).size.width/2.4,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(_duedate,style: TextStyle(fontSize: 18.0),),
                              IconButton(icon: Icon(Icons.calendar_today_outlined,size: 18.0,), onPressed: (){
                                DatePicker.showDatePicker(context,
                                    theme: DatePickerTheme(
                                      containerHeight: 210.0,
                                    ),
                                    showTitleActions: true,
                                    minTime: DateTime(2000, 1, 1),
                                    maxTime: DateTime(2100, 12, 31), onConfirm: (date) {
                                      print('confirm $date');
                                      int i = date.millisecondsSinceEpoch;
                                      _duedate = '${date.day}/${date.month}/${date.year}';
                                      setState(() {
                                        dateController.text = _duedate;
                                        due_val = i;
                                      });
                                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                              })
                            ],
                          ),
                        ),
                        onTap: (){
                          DatePicker.showDatePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true,
                              minTime: DateTime(2000, 1, 1),
                              maxTime: DateTime(2100, 12, 31), onConfirm: (date) {
                                print('confirm $date');
                                int i = date.millisecondsSinceEpoch;
                                _duedate = '${date.day}/${date.month}/${date.year}';
                                setState(() {
                                  dateController.text = _duedate;
                                  due_val = i;
                                });
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                      ),
                      if(due == false)
                        Text("Required",style: TextStyle(color: Colors.red),)
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Est. Min",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                      Container(
                        height: MediaQuery.of(context).size.height/25,
                        width: MediaQuery.of(context).size.width/3.2,
                        child: TextField(
                          controller: estminController,
                          style: TextStyle(fontSize: 20.0),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(252, 228, 219, 200.0),
                                ),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                              enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                                  borderSide: BorderSide(color: Color.fromRGBO(252, 228, 219, 200.0), width: 3.0))
                          ),
                        ),
                      ),
                      if(est == false)
                        Text("Required",style: TextStyle(color: Colors.red),)
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/15.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Actual Min",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                      Container(
                        height: MediaQuery.of(context).size.height/25,
                        width: MediaQuery.of(context).size.width/3.2,
                        child: TextField(
                          controller: actminController,
                          style: TextStyle(fontSize: 20.0),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(252, 228, 219, 200.0),
                                ),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                              enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                                  borderSide: BorderSide(color: Color.fromRGBO(252, 228, 219, 200.0), width: 3.0))
                          ),
                        ),
                      ),
                      if(act == false)
                        Text("Required",style: TextStyle(color: Colors.red),)
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/20.0,),
                  Column(
                    children: [
                      Text("Done",style: TextStyle(color: Colors.white,fontSize: 18.0,)),
                      SizedBox(height: MediaQuery.of(context).size.height/70,),
                      Container(
                        height: MediaQuery.of(context).size.height/40,
                        width: MediaQuery.of(context).size.width/6,
                        child: Checkbox(
                          checkColor: Colors.white,
                          value: complete,
                          onChanged: (newValue) {
                            setState(() {
                              complete = newValue;
                              if(complete == true){
                                compController.text = 1.toString();
                              }
                              else{
                                compController.text = 0.toString();
                              }
                            });
                          },
                        ),
                      ),
                    ],),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Review",style: TextStyle(color: Colors.white,fontSize: 18.0,)),
                      Container(
                        height: (_review == []) ? MediaQuery.of(context).size.height/25 : MediaQuery.of(context).size.height/8.8,
                        width: MediaQuery.of(context).size.width/1.11,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            MultiSelectFormField(
                              autovalidate: false,
                              chipBackGroundColor: Color.fromRGBO(102, 220, 130, 1.0),
                              chipLabelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              dialogTextStyle: TextStyle(fontSize: 22.0),
                              checkBoxActiveColor: Colors.green,
                              checkBoxCheckColor: Colors.white,
                              dialogShapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
                              dataSource: [
                                {
                                  "display": "Mon",
                                  "value": "Monday",
                                },
                                {
                                  "display": "Tues",
                                  "value": "Tuesday",
                                },
                                {
                                  "display": "Wed",
                                  "value": "Wednesday",
                                },
                                {
                                  "display": "Thurs",
                                  "value": "Thursday",
                                },
                                {
                                  "display": "Fri",
                                  "value": "Friday",
                                },
                                {
                                  "display": "Sat",
                                  "value": "Saturday",
                                },
                                {
                                  "display": "Sun",
                                  "value": "Sunday",
                                },
                              ],
                              hintWidget: Text("Select one or more entries from dropdown list "),
                              title: Container(height: 0.0,width: 0.0,),
                              textField: 'display',
                              valueField: 'value',
                              okButtonLabel: 'OK',
                              cancelButtonLabel: 'CANCEL',
                              initialValue: _review,
                              onSaved: (value) {
                                if (value == null) return;
                                setState(() {
                                  _review = value;
                                  print(_review);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Notes",style: TextStyle(color: Colors.white,fontSize: 18.0,)),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/25,
                          width: MediaQuery.of(context).size.width/1.1,
                          child: TextField(
                            controller: notesController,
                            style: TextStyle(fontSize: 20.0),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(252, 228, 219, 200.0),
                                  ),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                                enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                                    borderSide: BorderSide(color: Color.fromRGBO(252, 228, 219, 200.0), width: 3.0))
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    height: MediaQuery.of(context).size.height/12,
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      onPressed: () async {
                        if(learnController.text == ""){
                          setState(() {
                            learn = false;
                          });
                        }
                        else{
                          setState(() {
                            learn = true;
                          });
                        }
                        if(estminController.text == ""){
                          setState(() {
                            est = false;
                          });
                        }
                        else{
                          setState(() {
                            est = true;
                          });
                        }
                        if(actminController.text == ""){
                          setState(() {
                            act = false;
                          });
                        }
                        else{
                          setState(() {
                            act = true;
                          });
                        }
                        if(subjectController.text == ""){
                          setState(() {
                            sub = false;
                          });
                        }
                        else{
                          setState(() {
                            sub = true;
                          });
                        }
                        if(helpController.text == ""){
                          setState(() {
                            hel = false;
                          });
                        }
                        else{
                          setState(() {
                            hel = true;
                          });
                        }
                        if(due_val == 0){
                          setState(() {
                            due = false;
                          });
                        }
                        else{
                          setState(() {
                            due = true;
                          });
                        }
                        if(do_val == 0){
                          setState(() {
                            dod = false;
                          });
                        }
                        else{
                          setState(() {
                            dod = true;
                          });
                        }
                        if(_myPreparation.isEmpty){
                          setState(() {
                            prep = false;
                          });
                        }
                        else{
                          setState(() {
                            prep = true;
                          });
                        }
                        if(_myPractices.isEmpty){
                          setState(() {
                            prac = false;
                          });
                        }
                        else{
                          setState(() {
                            prac = true;
                          });
                        }

                        if(widget.id == null){
                          if((learnController.text != "") && (estminController.text != "")
                              && (actminController.text != "") && (subjectController.text != "")
                              && (helpController.text != "") && (due_val > 0)
                              && (do_val > 0) && (_myPreparation.isNotEmpty)
                              && (_myPractices.isNotEmpty)
                          ){
                            print(compController.text);
                            if(compController.text == ""){
                              setState(() {
                                compController.text = 0.toString();
                              });
                            }
                            form_model m = new form_model();
                            m.learn_to = learnController.text;
                            m.notes_to = notesController.text;
                            m.Helpers_name = helpController.text;
                            m.Course_name = subjectController.text;
                            m.Color_name = colorController.text;
                            m.act_min = int.parse(actminController.text);
                            m.est_min = int.parse(estminController.text);
                            m.due_date = due_val;
                            m.do_date = do_val;
                            m.prepare_to = _myPreparation.join(",");
                            m.practice_to = _myPractices.join(",");
                            if(_review.isNotEmpty){
                              m.review_to = _review.join(",");
                            }
                            else{
                              m.review_to = _review.join("");
                            }
                            m.complete = int.parse(compController.text);
                            var msg = await DBProvider.db.form_insert(m).then((value){
                              if(value == "Success"){
                                final snackBar = SnackBar(
                                  content: Text('Inserted!'),
                                );
                                _scaffoldKey.currentState.showSnackBar(snackBar);
                              }
                              else{
                                final snackBar = SnackBar(
                                  content: Text(value.toString()),
                                );
                                _scaffoldKey.currentState.showSnackBar(snackBar);
                              }
                            });
                          }
                        }
                        else{
                          if((learnController.text != "") && (estminController.text != "")
                              && (actminController.text != "") && (subjectController.text != "")
                              && (helpController.text != "") && (due_val > 0)
                              && (do_val > 0) && (_myPreparation.isNotEmpty)
                              && (_myPractices.isNotEmpty) && (_review.isNotEmpty)
                          ){
                            form_model m = new form_model();
                            m.id = widget.id;
                            m.learn_to = learnController.text;
                            m.notes_to = notesController.text;
                            m.Helpers_name = helpController.text;
                            m.Course_name = subjectController.text;
                            m.Color_name = colorController.text;
                            m.act_min = int.parse(actminController.text);
                            m.est_min = int.parse(estminController.text);
                            m.due_date = due_val;
                            m.do_date = do_val;
                            m.prepare_to = _myPreparation.join(",");
                            m.practice_to = _myPractices.join(",");
                            m.review_to = _review.join(",");
                            m.complete = int.parse(compController.text);
                            var msg = await DBProvider.db.Update_form(m).then((value){
                              if(value == "Success"){
                                final snackBar = SnackBar(
                                  content: Text('Updated!'),
                                );
                                _scaffoldKey.currentState.showSnackBar(snackBar);
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Calender()));
                              }
                              else{
                                final snackBar = SnackBar(
                                  content: Text(value.toString()),
                                );
                                _scaffoldKey.currentState.showSnackBar(snackBar);
                              }
                            });
                          }
                        }

                        setState(() {
                          dateController.text = "";
                          learnController.text = "";
                          doController.text = "";
                          estminController.text = "";
                          actminController.text = "";
                          notesController.text = "";
                          _myPreparation.clear();
                          _myPractices.clear();
                          _review.clear();
                        });
                      },
                      color: Color.fromRGBO(121, 205, 239, 1.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.black)
                      ),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    height: MediaQuery.of(context).size.height/12,
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          dateController.text = "";
                          learnController.text = "";
                          doController.text = "";
                          estminController.text = "";
                          actminController.text = "";
                          notesController.text = "";
                          _myPreparation.clear();
                          _myPractices.clear();
                          _review.clear();
                        });
                      },
                      color: Color.fromRGBO(121, 205, 239, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.black)
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
