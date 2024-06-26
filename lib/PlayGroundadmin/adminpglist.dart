import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground_user/PlayGroundadmin/AdminCpanal.dart';


class adminpglist extends StatefulWidget {
  @override
  _adminpglistState createState() => _adminpglistState();
}

class _adminpglistState extends State<adminpglist> {
  String userId;
  int price1 , price2 , price3 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الملاعب الخاصه بك"),centerTitle: true,backgroundColor: Colors.teal,),
      body: Center(
        child: Container(
          color: Colors.grey,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),/*
                Text(
                  "الملاعب الخاصه بك ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),*/
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('pgs')
                            .where("pgowner", isEqualTo: userId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                                child: Text(
                              " Loading play grounds .... ",
                              style: TextStyle(fontSize: 25),
                            ));
                          }
                          return ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot pgAdminlistSnapshot =
                                    snapshot.data.documents[index];


                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => pgAdminCpanal(
                                                  pgname: pgAdminlistSnapshot[
                                                      "pgname"],price1:pgAdminlistSnapshot['price1'] ,price2:pgAdminlistSnapshot['price2'] ,price3:pgAdminlistSnapshot['price3'] ,
                                                )));
                                  },
                                  child: Container(
                                    width: 200,
                                    child: Card(
                                      color: Colors.teal,
                                      child: Center(
                                        child: Container(
                                          height: 90,
                                          child: Center(
                                              child: Text(
                                            "${pgAdminlistSnapshot['name']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getUserId() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    setState(() {
      userId = user.uid;
      //usermail = user.email ;
    });
  }

  @override
  void initState() {
    getUserId();
  }
}
