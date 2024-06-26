import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playground_user/User/Reservationpage.dart';

class PlayGroundList extends StatefulWidget {
  static const String id = "pglist";
  @override
  _PlayGroundListState createState() => _PlayGroundListState();
}

class _PlayGroundListState extends State<PlayGroundList> {
  int price1 , price2 ,price3 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true,
          title: Text("الملاعب المتاحة",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          backgroundColor: Colors.lightGreen,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/pglist.jpg'), fit: BoxFit.fill)),
          child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                color: Colors.white10,
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
                            DocumentSnapshot pgSnapshot =
                                snapshot.data.documents[index];

                            return InkWell(onTap: (){



                              Navigator.push(context, MaterialPageRoute(builder: (_)=>ReservationPage(pgname: pgSnapshot["pgname"],)  ));

                            },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4,right: 8,top: 4),
                                child: Card(elevation: 1,
                                  color: Colors.white70,
                                  child: Container(
                                    width: double.infinity,
                                    //color: Colors.transparent,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(pgSnapshot["pgpic"]),
                                            radius: 35,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "${pgSnapshot["name"]}",
                                                style: TextStyle(fontWeight: FontWeight.w900,
                                                    fontSize: 25,
                                                    color: Colors.black54),
                                                textAlign: TextAlign.justify,
                                              ),
                                              Center(
                                                  child: Text(
                                                "${pgSnapshot["address"]}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              )),
        ));
  }


}
