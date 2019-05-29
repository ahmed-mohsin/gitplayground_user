import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../playgroundlist.dart';
import 'Signup.dart';


class Login extends StatefulWidget {
  static const String id = "login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextStyle textstyle =
  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold);
  final InputDecoration decoration = InputDecoration(
    border: OutlineInputBorder(),
  );

  Future<bool> _onBackPressed ()async{
    return showDialog(context: context,
        builder: (BuildContext context){
      return AlertDialog(
        title: Text("do you really want to exit the app"),
        actions: <Widget>[
          FlatButton(
            child: Text("No"),
            onPressed: ()=>Navigator.pop(context,false),
          ),
          FlatButton(
          child: Text("yes"),
          onPressed: ()=>exit(0),
          )
        ],
      );
        });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(

        body: Center(

          child: SingleChildScrollView(


            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlutterLogo(
                    size: 190,
                  ),
                  RaisedButton(



                    color: Colors.blue,

                    child: Text(
                      'Facebook',
                      style: textstyle,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: decoration,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: decoration,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                FlatButton(onPressed: (){
                  Navigator.pushNamed(context, PlayGroundList.id);
                }, child: Container(
                  color: Colors.red,
                  child: Text(
                    'Google',
                    style: textstyle,
                  ),
                ))

              , MaterialButton(

                    color: Colors.blue,
                    minWidth: 160,
                    child: Text(
                      'Facebook',
                      style: textstyle,
                    ),
                  ),
                  MaterialButton(
                    color: Colors.orange,
                    minWidth: 160,
                    child: Text(
                      'E-mail',
                      style: textstyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
