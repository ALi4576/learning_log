import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_planner/Screens/slider.dart';
import 'Screens/calender.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Power Learners App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _loadWidget(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.data == null) {
              return splash_slider();
            } else {
              return snapshot.data == "true" ? Calender(show_todo: "ToDo",) : splash_slider();
            }
          }
          return Scaffold(body: Center(child: CircularProgressIndicator(),));
        },
      )
    );
  }
  static String boolValue;
  Future<String> _loadWidget() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    boolValue = preferences.getString("Value");
    return boolValue;
  }
}
