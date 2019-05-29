import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Reservationpage.dart';

class PlayGroundList extends StatefulWidget {
  static const String id = "pglist";
  @override
  _PlayGroundListState createState() => _PlayGroundListState();
}

class _PlayGroundListState extends State<PlayGroundList> {
  List names = ["gam3a", "talkha", "ahly", "zamalek", "mansoura"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              color: Colors.white30,
              child: StreamBuilder(
                  stream: Firestore.instance.collection('pgs').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Text(
                        " Loading play grounds .... ",
                        style: TextStyle(fontSize: 25),
                      ));
                    }
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot caseSnapshot =
                              snapshot.data.documents[index];

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReservationPage(
                                            pgname: "${caseSnapshot["name"]}",
                                          ))),
                              child: Card(
                                elevation: 2,
                                color: Colors.green.shade300,
                                child: Center(
                                    child: Text("  ${caseSnapshot["name"]}")),
                              ),
                            ),
                          );
                        });
                  }),
            )));
  }
}
