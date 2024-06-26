import 'package:flutter/material.dart';
import 'package:playground_user/User/UserProfile.dart';

class Congratulation extends StatelessWidget {
  var refNumber, ExpirationDate;

  Congratulation({this.refNumber, this.ExpirationDate});



  @override
  Widget build(BuildContext context) {

   
    
    return WillPopScope(onWillPop: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfile()));
    },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            alignment: Alignment.center,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Icon(Icons.check_circle,size: 100,color: Colors.lightGreen,),
                  Text(
                    "تهانينا ",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.green),
                  ),
                  Text(
                    " يمكنك الآن الذهاب لاقرب نقطه فوري و  تنفيذ عمليه الدفع  لاتمام عمليه الحجز قبل  ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    "${DateTime.fromMillisecondsSinceEpoch(ExpirationDate)}",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.pink,
                        fontWeight: FontWeight.w800),
                  ),
                  Text("رقم العمليه "),
                  Text(
                    "  $refNumber  ",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w900,
                        fontSize: 15),
                  ),
                  Text(
                    "  ستجد ايضا الرقم علي الموبايل الذي قمت بادخاله سابقا  ",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 15),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 50,left: 50),
                    child: Divider(color: Colors.grey,),
                  ),
                  Text(
                    " ملاحظة لن تكتمل عملية الحجز اذا لم تقم بالدفع خلال ساعة من الآن و سيكون بمقدور اي شخص حجز الساعه مرة اخري ",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold),
                  ),
                  //زر وهمي فقط للوصل  الصفحه التاليه لصفحه فوري في حاله اتمام الدفع طبعا سيتم الغاءه عند اضاءه كود فوري

                  Spacer(),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => UserProfile()));
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: 140,
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "التذاكر الخاصة بك",
                              style: TextStyle(color: Colors.white),
                            ),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }





}
