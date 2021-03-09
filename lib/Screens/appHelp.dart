import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class appHelp extends StatefulWidget {
  @override
  _appHelpState createState() => _appHelpState();
}

class _appHelpState extends State<appHelp> {
  final learningPlanKey = new GlobalKey();
  final calendarKey = new GlobalKey();
  final createKey = new GlobalKey();
  final doKey = new GlobalKey();
  final reKey = new GlobalKey();
  final whyKey = new GlobalKey();
  ScrollController _scrollController = ScrollController();
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: visible,
        child: FloatingActionButton(
          child: Icon(Icons.keyboard_arrow_up),
            onPressed: (){
              _scrollController.animateTo(
                  _scrollController.position.minScrollExtent,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease);
            }
        ),
      ),
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
          var metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            if (metrics.pixels == 0) setState(() => visible = false);
            else setState(() => visible = true);
          }
          else setState(() => visible = true);
          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              //Page 1
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60.0,
                          width: 60.0,
                          child: Image(image: AssetImage('img/1.png'))
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/20,),
                        Text("Power Learners App \nUser's Guide",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,decoration:TextDecoration.underline ),)
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Learn faster ● Get better grades ● Remember longer",style: TextStyle(fontSize: 14.0))
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/12,left: MediaQuery.of(context).size.width/25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Overview",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,decoration:TextDecoration.underline ),)
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("The Power Learners App helps you plan\n"
                            "how best to practice and master each lesson.\n"
                            "It also helps you manage your study time\n"
                            "and track increases in your learning speed.\n"
                            "There are three screens:",style: TextStyle(fontSize: 16.0))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                    child: Container(
                      child: Image(image: AssetImage('img/appHelp Image page 1-1.jpg'),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width/35,),
                        GestureDetector(
                          child: Text("Learning Plan",style: TextStyle(fontSize: 18.0,color: Colors.indigoAccent,decoration: TextDecoration.underline),),
                          onTap: (){
                             Scrollable.ensureVisible(learningPlanKey.currentContext);
                          },
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/11,),
                        GestureDetector(
                          child: Text("Calendar",style: TextStyle(fontSize: 18.0,color: Colors.indigoAccent,decoration: TextDecoration.underline),),
                          onTap: (){
                            Scrollable.ensureVisible(calendarKey.currentContext);
                          },
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/7,),
                        GestureDetector(
                          child: Text("Settings",style: TextStyle(fontSize: 18.0,color: Colors.indigoAccent,decoration: TextDecoration.underline),),
                          onTap: (){
                             Scrollable.ensureVisible(calendarKey.currentContext);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              //Page 2
              Padding(
                key: learningPlanKey,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/13,bottom: MediaQuery.of(context).size.height/15),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15,left: MediaQuery.of(context).size.width/25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("How to Use the App",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,decoration:TextDecoration.underline ),)
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 7.0,
                                width: 7.0,
                                decoration: new BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width/18,),
                              Text("Create a New Learning Plan",style: TextStyle(fontSize: 17.0)),
                              SizedBox(width: MediaQuery.of(context).size.width/18,),
                              GestureDetector(
                                child: Text("Details",style: TextStyle(fontSize: 17.0,color: Colors.indigoAccent,decoration: TextDecoration.underline),),
                                onTap: (){
                                  Scrollable.ensureVisible(createKey.currentContext);
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 7.0,
                                width: 7.0,
                                decoration: new BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width/18,),
                              Text("Do the Learning",style: TextStyle(fontSize: 17.0)),
                              SizedBox(width: MediaQuery.of(context).size.width/18,),
                              GestureDetector(
                                child: Text("Details",style: TextStyle(fontSize: 17.0,color: Colors.indigoAccent,decoration: TextDecoration.underline),),
                                onTap: (){
                                  Scrollable.ensureVisible(doKey.currentContext);
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 7.0,
                                width: 7.0,
                                decoration: new BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width/18,),
                              Text("Review for Long-term",style: TextStyle(fontSize: 17.0)),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/14),
                            child: Row(
                              children: [
                                Text("Remembering",style: TextStyle(fontSize: 17.0)),
                                SizedBox(width: MediaQuery.of(context).size.width/18,),
                                GestureDetector(
                                  child: Text("Details",style: TextStyle(fontSize: 17.0,color: Colors.indigoAccent,decoration: TextDecoration.underline),),
                                  onTap: (){
                                    Scrollable.ensureVisible(reKey.currentContext);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/25,left: MediaQuery.of(context).size.width/25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Why It Works...",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                          SizedBox(width: MediaQuery.of(context).size.width/18,),
                          GestureDetector(
                            child: Text("Details",style: TextStyle(fontSize: 17.0,color: Colors.indigoAccent,decoration: TextDecoration.underline),),
                            onTap: (){
                              Scrollable.ensureVisible(whyKey.currentContext);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15,bottom: MediaQuery.of(context).size.height/5),
                      child: Container(
                        child: Image(image: AssetImage('img/appHelp Image page 2-1.png'),),
                      ),
                    ),
                  ],
                ),
              ),
              //Page 3
              Padding(
                key: calendarKey,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15,bottom: MediaQuery.of(context).size.height/5),
                child: Container(
                  child: Image(image: AssetImage('img/appHelp Image page 3-1.jpg'),),
                ),
              ),
              //Page 4
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15,bottom: MediaQuery.of(context).size.height/5),
                child: Container(
                  child: Image(image: AssetImage('img/appHelp Image page 4-1.jpg'),),
                ),
              ),
              //Page 5
              Column(
                key: createKey,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/12,left: MediaQuery.of(context).size.width/25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Create a New Learning Plan",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,decoration:TextDecoration.underline ),)
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                        child: Text("On the Calendar,\nclick + to add \na new Learning \nPlan",style: TextStyle(fontSize: 18.0),),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Image(image: AssetImage('img/appHelp Image page 5-1.jpg'),))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Select the\nCourse and\na Helper from\ndropdown lists",style: TextStyle(fontSize: 18.0),),
                      Container(
                          width: MediaQuery.of(context).size.width/1.8,
                          height: MediaQuery.of(context).size.height/4,
                          child: Image(image: AssetImage('img/appHelp Image page 5-2.jpg'),))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Enter what you\nwill learn to do",style: TextStyle(fontSize: 18.0),),
                      Container(
                          width: MediaQuery.of(context).size.width/2,
                          height: MediaQuery.of(context).size.height/6,
                          child: Image(image: AssetImage('img/appHelp Image page 5-3.jpg'),))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Select how you will\nprepare and practice\nfrom dropdown lists\n(Items will display\nin the order you select)",style: TextStyle(fontSize: 18.0),),
                      Container(
                          width: MediaQuery.of(context).size.width/2.5,
                          height: MediaQuery.of(context).size.height/3,
                          child: Image(image: AssetImage('img/appHelp Image page 5-4.jpg'),))
                    ],
                  ),
                ],
              ),
              //Page 6
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Select the Do Date\nwhen you will learn\nand the Due Date\nwhen you must\nturn it in",style: TextStyle(fontSize: 18.0),),
                      Container(
                          width: MediaQuery.of(context).size.width/2,
                          height: MediaQuery.of(context).size.height/3,
                          child: Image(image: AssetImage('img/appHelp Image page 5-5.jpg'),))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Estimate how many\nminutes it will take,\nadd any notes,\nand click Save",style: TextStyle(fontSize: 18.0),),
                      Container(
                          width: MediaQuery.of(context).size.width/2,
                          height: MediaQuery.of(context).size.height/3,
                          child: Image(image: AssetImage('img/appHelp Image page 5-6.jpg'),))
                    ],
                  ),
                ],
              ),
              //Page 7
              Padding(
                key: doKey,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/13),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15,left: MediaQuery.of(context).size.width/25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Do the Learning",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,decoration:TextDecoration.underline ),)
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25),
                      child: Text("When you start an assignment, click to open the Learning Plan and follow it.",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25),
                      child: Row(
                        children: [
                          Container(
                            height: 7.0,
                            width: 7.0,
                            decoration: new BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/18,),
                          Text("Click an assignment on the Calendar to \nopen the Learning Plan",style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25),
                      child: Row(
                        children: [
                          Container(
                            height: 7.0,
                            width: 7.0,
                            decoration: new BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/18,),
                          Text("Jot down the time you start",style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25),
                      child: Row(
                        children: [
                          Container(
                            height: 7.0,
                            width: 7.0,
                            decoration: new BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/18,),
                          Text("Do the preparation and practice",style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25),
                      child: Row(
                        children: [
                          Container(
                            height: 7.0,
                            width: 7.0,
                            decoration: new BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/18,),
                          Text("If you need help, call a Helper",style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25),
                      child: Row(
                        children: [
                          Container(
                            height: 7.0,
                            width: 7.0,
                            decoration: new BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/18,),
                          Text("Continue practicing until you could get \nan A if there were a test tomorrow",style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/13,bottom: MediaQuery.of(context).size.height/18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Enter the Actual\nMinutes to learn\nthe lesson and click\nDone",style: TextStyle(fontSize: 17.0),),
                          SizedBox(height: 10.0,),
                          Text("Enter one or two\nReview dates when\nyou will re-practice\nto mastery",style: TextStyle(fontSize: 17.0),),
                          SizedBox(height: 10.0,),
                          Text("Save the Learning\nPlan",style: TextStyle(fontSize: 17.0),),
                        ],
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Image(image: AssetImage('img/appHelp Image page 6-1.jpg'),))
                  ],
                ),
              ),
              //Page 8
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      key: reKey,
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15,left: MediaQuery.of(context).size.width/25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Review for Long-term Remembering",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,decoration:TextDecoration.underline ),)
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25,right: MediaQuery.of(context).size.width/25),
                      child: Text("On the Calendar, click to open a Learning Plan scheduled for Review",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25,right: MediaQuery.of(context).size.width/25),
                      child: Text("Re-practice until you could get an A if there were a test tomorrow",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25,right: MediaQuery.of(context).size.width/25),
                      child: Text("If you get stuck, call a Helper",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25,right: MediaQuery.of(context).size.width/25),
                      child: Text("If you think you need it, schedule another review on a different day",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25),
                      child: Text("Save",style: TextStyle(fontSize: 17.0)),
                    ),
                  ],
                ),
              ),
              Padding(
                key: whyKey,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15,bottom: MediaQuery.of(context).size.height/20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15,left: MediaQuery.of(context).size.width/25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Why It Works",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,decoration:TextDecoration.underline ),)
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/25,right: MediaQuery.of(context).size.width/25),
                      child: Text("This app is based on nine proven principles of learning:",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22,right: MediaQuery.of(context).size.width/25),
                      child: Text("1. Teaching gets you started, then you learn mostly by practicing.",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22,right: MediaQuery.of(context).size.width/25),
                      child: Text("2. No one ever became good at anything without practice.",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22,right: MediaQuery.of(context).size.width/25),
                      child: Text("3. Practice what you need to do on tests—answer, solve or discuss in writing.",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22,right: MediaQuery.of(context).size.width/25),
                      child: Text("4. When practicing, persevere so long as you are making progress.",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22,right: MediaQuery.of(context).size.width/25),
                      child: Text("5. When you get stuck, get help right away. Then continue practicing.",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22,right: MediaQuery.of(context).size.width/25),
                      child: Text("6. Mastering today’s lesson takes a little extra time but saves even more time on subsequent assignments and feels great.",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22,right: MediaQuery.of(context).size.width/25),
                      child: Text("7. Falling behind slows you down and is discouraging.",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22,right: MediaQuery.of(context).size.width/25),
                      child: Text("8. Estimating the time to learn each assignment breaks your work into small, doable steps, helping you overcome procrastination.",style: TextStyle(fontSize: 17.0)),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22,right: MediaQuery.of(context).size.width/25),
                      child: Text("9. Comparing your estimated and actual times improves your accuracy and shows increases in your learning rate.",style: TextStyle(fontSize: 17.0)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15,left: MediaQuery.of(context).size.width/25,bottom: MediaQuery.of(context).size.height/20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Contact Us",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,decoration:TextDecoration.underline ),),
                    SizedBox(height: 15.0,),
                    Text("If you have questions about using the app to become a Power Learner, email us at",style: TextStyle(fontSize: 17.0),),
                    GestureDetector(
                      child: Text("coach@powerlearners.com",style: TextStyle(fontSize: 17.0,color: Colors.indigoAccent,decoration: TextDecoration.underline),),
                      onTap: (){
                        final Uri _emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'coach@powerlearners.com',
                        );
                        launch(_emailLaunchUri.toString());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
