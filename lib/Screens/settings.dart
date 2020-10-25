import 'package:flutter/material.dart';
import 'package:student_planner/Database/database_sett.dart';
import 'package:student_planner/Models/settingsModel.dart';

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
  Future getsettings;
  List<String> Courses = new List(10);
  List<String> Helpers = new List(10);

  reset() async{
    setState(() {
      getsettings = DBProvider.db.getAllSettings();
      gethelp = DBProvider.db.getAllHelp();
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
    Courses[0] = "0xFFFF8181";
    Courses[1] = "0xFFFFD319";
    Courses[2] = "0xFFFFFF66";
    Courses[3] = "0xFFCCF438";
    Courses[4] = "0xFF01FF01";
    Courses[5] = "0xFF17F9C9";
    Courses[6] = "0xFF43CEFF";
    Courses[7] = "0xFFE885FF";
    Courses[8] = "0xFFDDDDDD";
    Courses[9] = "0xFFFFFFFF";
    return Scaffold(
      body: Container(
          color: Color.fromRGBO(51, 102, 255, 1),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
            child: Column(
              children: [
                Center(
                    child: Text(
                  "Learning Log Settings",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 27.0,
                      fontWeight: FontWeight.w500),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(Icons.keyboard_backspace),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
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
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: TextField(
                              controller: courseController,
                              style: TextStyle(fontSize: 20.0),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  hintText: "Add Course",
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
                      Container(
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width / 3,
                        child: TextField(
                          controller: positionController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 20.0),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              hintText: "Color 1-10",
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(252, 228, 219, 200.0),
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromRGBO(252, 228, 219, 200.0),
                                      width: 3.0))),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {
                            if (courseController.text != "" &&
                                (int.parse(positionController.text) > 0 &&
                                    int.parse(positionController.text) < 11)) {
                              Settings_Stu newClient = new Settings_Stu();
                              newClient.id = int.parse(positionController.text);
                              newClient.Course_name = courseController.text;
                              newClient.Color_name = Courses[int.parse(positionController.text) - 1];
                              DBProvider.db.newSettings(newClient);
                              reset();
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
                      Expanded(
                        child: Container(
                          color: Color(int.parse(Courses[0].toString())),
                          child: Center(child: Text("1")),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(int.parse(Courses[1].toString())),
                          child: Center(child: Text("2")),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(int.parse(Courses[2].toString())),
                          child: Center(child: Text("3")),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(int.parse(Courses[3].toString())),
                          child: Center(child: Text("4")),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(int.parse(Courses[4].toString())),
                          child: Center(child: Text("5")),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(int.parse(Courses[5].toString())),
                          child: Center(child: Text("6")),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(int.parse(Courses[6].toString())),
                          child: Center(child: Text("7")),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(int.parse(Courses[7].toString())),
                          child: Center(child: Text("8")),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(int.parse(Courses[8].toString())),
                          child: Center(child: Text("9")),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color(int.parse(Courses[9].toString())),
                          child: Center(child: Text("10")),
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
                            width: MediaQuery.of(context).size.width / 2.5,
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
                            }
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40.0,
                ),
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
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          Settings_Stu item = snapshot.data[index];
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
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 10),
                              child: FutureBuilder<List<Help_Stu>>(
                                future: gethelp,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width / 2.7,
                                      height: MediaQuery.of(context).size.height / 2,
                                      child: ListView.builder(
                                        itemCount: snapshot.data.length,
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
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 65.0,
                      padding: EdgeInsets.all(10.0),
                      child: RaisedButton(
                        onPressed: () {},
                        color: Color.fromRGBO(68, 114, 196, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.white)),
                        child: Center(
                          child: Text(
                            "User Guide",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 65.0,
                      padding: EdgeInsets.all(10.0),
                      child: RaisedButton(
                        onPressed: () {
                          _showDialog();
                        },
                        color: Color.fromRGBO(68, 114, 196, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.white)),
                        child: Center(
                          child: Text(
                            "Delete All",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
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

  Widget courses(String cl, String name, int num) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.7,
          height: MediaQuery.of(context).size.height / 20,
          color: Color(int.parse(cl)).withOpacity(0.8),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/30),
                child: Center(
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
              if (name != " ")
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      Settings_Stu newClient = new Settings_Stu();
                      newClient.id = num;
                      DBProvider.db.deleteClient(newClient.id);
                      setState(() {
                        reset();
                      });
                    }),
            ],
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
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/30),
                child: Center(
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
              if (name != " ")
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      Help_Stu newClient = new Help_Stu();
                      newClient.id = num;
                      DBProvider.db.deleteHelp(newClient.id);
                      setState(() {
                        reset();
                      });
                    }),
            ],
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
