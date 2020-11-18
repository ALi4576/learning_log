import 'package:flutter/material.dart';
import 'package:student_planner/Database/database_sett.dart';
import 'package:student_planner/Models/settingsModel.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final courseController = TextEditingController();
  final helpController = TextEditingController();
  final positionController = TextEditingController();
  final poshelpController = TextEditingController();
  Future gethelp;
  List<String> Courses = new List(10);
  List<String> Helpers = new List(10);
  Color bckcolor;
  bool st = false;
  Future<List<Settings_Stu>> getsettings;
  reset() async{
    setState(() {
      gethelp = DBProvider.db.getHelp();
      getsettings = DBProvider.db.getset();
    });
  }

  colorchange(int val){
    setState(() {
      bckcolor = Color(val);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      reset();
    });
  }


  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      body: Container(
          color: Color.fromRGBO(183, 181, 199, 1.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(Icons.keyboard_backspace),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    SizedBox(width: MediaQuery.of(context).size.width/4.4,),
                    Center(child: Text("Settings",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w500),)),
                  ],
                ),
                /*Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 20,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: TextField(
                              controller: courseController,
                              style: TextStyle(fontSize: 20.0),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  hintText: "Add Course",
                                  fillColor: (positionController.text.isNotEmpty) ? bckcolor : Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                    borderSide: BorderSide(
                                      color:
                                          Color.fromRGBO(252, 228, 219, 200.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 0.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              252, 228, 219, 200.0),
                                          width: 3.0))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {
                            if (courseController.text != "" && positionController.text != "") {
                              Settings_Stu newClient = new Settings_Stu();
                              newClient.id = int.parse(positionController.text);
                              newClient.Course_name = courseController.text;
                              newClient.Color_name = Courses[int.parse(positionController.text) - 1];
                              DBProvider.db.newSettings(newClient);
                              getsettings = DBProvider.db.getAllSettings().then((value) => reset());
                              setState(() {
                                positionController.text = "";
                                courseController.text = "";
                              });
                            }
                          })
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 30,right: MediaQuery.of(context).size.width / 30),
                  child: Row(
                    children: [
                      for(int i = 0 ; i < 10;i++) Expanded(
                        child: GestureDetector(
                          child: Container(
                            height: MediaQuery.of(context).size.height/20,
                            color: Color(int.parse(Courses[i].toString())),
                          ),
                          onTap: (){
                            setState(() {
                              positionController.text = (i + 1).toString();
                              colorchange(int.parse(Courses[i].toString()));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 20,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: TextField(
                              controller: helpController,
                              style: TextStyle(fontSize: 20.0),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  hintText: "Helpers",
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                    borderSide: BorderSide(
                                      color:
                                          Color.fromRGBO(252, 228, 219, 200.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 0.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              252, 228, 219, 200.0),
                                          width: 3.0))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {
                            if (helpController.text != "")
                            {
                              Help_Stu add_help = new Help_Stu();
                              add_help.Helper_name = helpController.text;
                              DBProvider.db.newHelp(add_help);
                              reset();
                              setState(() {
                                helpController.text = "";
                              });
                            }
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40.0,
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Courses",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Helpers",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Container(
                  child: Expanded(
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 10),
                              child: FutureBuilder<List<Settings_Stu>>(
                                future: getsettings,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width / 2.7,
                                      height: MediaQuery.of(context).size.height / 2,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: 10,
                                        itemBuilder: (BuildContext context, int index) {
                                          Settings_Stu item = snapshot.data[index];
                                          courseController.text = item.Course_name;
                                          return courses(item.Color_name, item.Course_name, item.id);
                                        },
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),
                              child: FutureBuilder<List<Help_Stu>>(
                                future: gethelp,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width / 2.7,
                                      height: MediaQuery.of(context).size.height / 2,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: 10,
                                        itemBuilder: (BuildContext context, int index) {
                                            Help_Stu item = snapshot.data[index];
                                            return helpers(item.Helper_name, item.id);
                                        },
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: MediaQuery.of(context).size.height/10.5,
                      padding: EdgeInsets.all(10.0),
                      child: RaisedButton(
                        onPressed: _launchURL,
                        color: Color.fromRGBO(28, 136, 229, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                            ),
                        child: Center(
                          child: Text(
                            "User Guide",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: MediaQuery.of(context).size.height/10.5,
                      padding: EdgeInsets.all(10.0),
                      child: RaisedButton(
                        onPressed: () {
                          _showDialog();
                        },
                        color: Color.fromRGBO(28, 136, 229, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Text(
                            "Delete All Assignments",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }

  _launchURL() async {
    const url = 'https://www.PowerLearners.com/LearningLog/UserGuide/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget courses(String cl, String name, int num) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.7,
          height: MediaQuery.of(context).size.height / 20,
          color: Color(int.parse(cl)),
          child: TextFormField(
            initialValue: name,
            onChanged: (value){
              Settings_Stu st = new Settings_Stu();
              st.id = num;
              st.Course_name = value;
              st.Color_name = cl;
              DBProvider.db.Update_set(st);
            },
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                fillColor: (Color(int.parse(cl))),
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(
                    10.0, 0.0, 0.0, 0.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(
                            252, 228, 219, 200.0),
                        width: 3.0))),
          ),
        )
      ],
    );
  }

  Widget helpers(String name, int num) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.7,
          height: MediaQuery.of(context).size.height / 20,
          child: TextFormField(
            initialValue: name,
            onChanged: (value){
              Help_Stu st = new Help_Stu();
              st.id = num;
              st.Helper_name = value;
              DBProvider.db.Update_help(st);
            },
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(
                    10.0, 0.0, 0.0, 0.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(
                            252, 228, 219, 200.0),
                        width: 3.0))),
          ),
        )
      ],
    );
  }

  void _showDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
            builder: (context,setState){
            return AlertDialog(
              title: new Text("Delete"),
              content: new Text("All Settings, Helpers and Assignment will be deleted"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Yes"),
                  onPressed: () {
                    DBProvider.db.deleteall().then((value) => {
                      reset()
                    });
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("No"),
                  onPressed: () {
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
