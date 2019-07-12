import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground_user/User/paybyFawry.dart';
import 'package:playground_user/User/playgroundlist.dart';

import 'Tickets.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var userId  ;
  var usermail ;

  Future<void> getUserId ()async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    setState(() {
       userId = user.uid ;
       usermail = user.email ;
    });
  }

  Future<void>_signout()async{


    FirebaseAuth.instance.signOut();
    exit(0);

  }


  Future<bool> _onBackPressed() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("do you really want to exit the app"),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () => Navigator.pop(context, false),
              ),
              FlatButton(
                child: Text("yes"),
                onPressed: _signout,
              )
            ],
          );
        });
  }



  @override
  void initState() {
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onBackPressed,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/ubg.jpg'), fit: BoxFit.cover)),
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*Text(
                "أهلا أحمد",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.pink,
                    fontWeight: FontWeight.bold),
              ),*/
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayGroundList()));
                  },
                  child: Container(
                      decoration: ShapeDecoration(
                          color: Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      width: 280,
                      height: 80,
                      child: Center(
                          child: Text(
                            "احجز ملعب",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )))),
              SizedBox(
                height: 5,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => payatfawry(userid: userId,)));
                  },
                  child: Container(
                      decoration: ShapeDecoration(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      width: 280,
                      //color: Colors.indigoAccent,
                      height: 80,
                      child: Center(
                          child: Text(
                            "الدفع بواسطه فوري",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )))),
              SizedBox(height: 5,),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Tickets()));
                  },
                  child: Container(
                      decoration: ShapeDecoration(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      width: 280,
                      //color: Colors.indigoAccent,
                      height: 80,
                      child: Center(
                          child: Text(
                            "تذاكر حجوزاتك",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )))),
            ],
          ),
        ),
      ),
    );
  }
}
