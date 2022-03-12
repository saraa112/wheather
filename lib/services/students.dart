import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Students extends StatelessWidget {
     final   sreeamStudents;
     final   userMail;
    Students({this.sreeamStudents,this.userMail});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: sreeamStudents,
        builder: (context ,snapshot)
       {
          if(snapshot.hasData)
            {
             QuerySnapshot values= snapshot.data as QuerySnapshot;
             return Expanded(
               child: ListView.builder(
                   itemCount:values.docs.length ,
                   itemBuilder: (Context,index)
               {
                 return Container(
                   padding: EdgeInsets.all(8),
                   child: Column(
                     children: [
                       Row(
                         children: [
                           Text(values.docs[index]['name'],
                             style: TextStyle(
                                 color: Colors.red,
                                 fontSize: 20
                             ),),
                           Text(values.docs[index]['age'],
                             style: TextStyle(
                                 color: Colors.red,
                                 fontSize: 20
                             ),)
                         ],
                       )

                     ],
                   ),
                 );
               }
               ));
          }
          else {
            Center(
              child:
              const Text('data is empty'),
            );
            return Container();
          }});

  }
}
