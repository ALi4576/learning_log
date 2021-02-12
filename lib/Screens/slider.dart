import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_planner/Screens/calender.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Assign_Form.dart';

class splash_slider extends StatefulWidget {
  @override
  _splash_sliderState createState() => _splash_sliderState();
}

class _splash_sliderState extends State<splash_slider> {
  @override
  void initState() {
    super.initState();
  }

  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/40,top: MediaQuery.of(context).size.height/35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/40,right: MediaQuery.of(context).size.width/40,),
                    child: Image(image: AssetImage('img/1.png'),width: 70.0,),
                  ),
                  Text("Power Learners App",style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.bold,fontSize: 27.0),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/8),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(" Learn faster\n Get better grades\n Remember longer",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w500),)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/40,top: MediaQuery.of(context).size.height/3.8),
              child: Text('In Four Steps',style: TextStyle(color: Colors.black, fontSize: 24.0,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/40,top: MediaQuery.of(context).size.height/3),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10.0,
                        width: 10.0,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(' Learn by practicing what you need',style: TextStyle(color: Colors.black, fontSize: 22.0),),
                    ],
                  ),
                  Row(
                    children: [
                      Text('or want to be able to do.',style: TextStyle(color: Colors.black, fontSize: 22.0),),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/1.5,top:MediaQuery.of(context).size.height/18),
              child: Align(
                alignment: Alignment.center,
                child: Image(image: AssetImage('img/2.jpg'),width: 115.0,),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/40,top: MediaQuery.of(context).size.height/2.3),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10.0,
                        width: 10.0,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(' Practice until you could',style: TextStyle(color: Colors.black, fontSize: 22.0),),
                    ],
                  ),
                  Row(
                    children: [
                      Text('get an A if there were',style: TextStyle(color: Colors.black, fontSize: 22.0),),
                    ],
                  ),
                  Row(
                    children: [
                      Text('a test tomorrow.',style: TextStyle(color: Colors.black, fontSize: 22.0),),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/40,top: MediaQuery.of(context).size.height/1.75),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10.0,
                        width: 10.0,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(' If you are stuck, get',style: TextStyle(color: Colors.black, fontSize: 22.0),),
                    ],
                  ),
                  Row(
                    children: [
                      Text('help that minute. Then',style: TextStyle(color: Colors.black, fontSize: 22.0),),
                    ],
                  ),
                  Row(
                    children: [
                      Text('continue practicing.',style: TextStyle(color: Colors.black, fontSize: 22.0),),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/40,top: MediaQuery.of(context).size.height/1.42),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10.0,
                        width: 10.0,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(' Review on two other days.',style: TextStyle(color: Colors.black, fontSize: 22.0),),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/40,top: MediaQuery.of(context).size.height/1.28),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Start: ',style: TextStyle(color: Colors.black, fontSize: 22.0,fontWeight: FontWeight.bold),),
                      GestureDetector(
                        onTap: (){
                          addBoolToSF(check);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                AssignemntForm(id: null,Course_name: "",Color_name: "",Helpers_name: "", learn_to: "", prepare_to: "", practice_to: "", do_date: 0, due_date: 0, est_min: 0, act_min: 0, review_1: 0, review_2: 0, notes_to: "",show_todo: "ToDo",)),
                          );
                        },
                        child:
                        Text('Create a Learning Plan',style: TextStyle(color: Colors.black, fontSize: 22.0,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/40,top: MediaQuery.of(context).size.height/1.20),
              child: GestureDetector(
                onTap: _launchURL,
                child:
                Text('User Guide',style: TextStyle(color: Colors.black, fontSize: 22.0,decoration: TextDecoration.underline),),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/1.13),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/40,
                        width: MediaQuery.of(context).size.width/9,
                        child: Checkbox(
                          checkColor: Colors.white,
                          value: check,
                          onChanged: (newValue) {
                            setState(() {
                              check = newValue;
                            });
                            Future.delayed(const Duration(milliseconds: 800), () {
                              if(check == true){
                                addBoolToSF(check);
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Calender(show_todo: "ToDo",)));
                              }
                            });
                          },
                        ),
                      ),
                      Text('Do not show this again',style: TextStyle(color: Colors.black, fontSize: 22.0),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  addBoolToSF(bool check) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Value', check.toString());
  }
  _launchURL() async {
    const url = 'http://powerlearners.com/AppHelp/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
