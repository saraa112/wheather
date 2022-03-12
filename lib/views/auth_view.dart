import 'package:flutter/material.dart';
import 'package:school/views/auth_form.dart';

class AuthScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:SingleChildScrollView(
       child:Column(
         children: [
           Stack(
             children: [
               Container(
                 height:MediaQuery.of(context).size.height*0.5,
                 decoration: BoxDecoration(
                     color: Colors.lightBlue,
                     borderRadius: BorderRadius.only(
                         bottomLeft:Radius.circular(50) ,
                         bottomRight: Radius.circular(50)
                     )
                 ),
               ),
               Column(
                 children: [
                   SizedBox(height: 60,),
                   Text('مصنع النعيم للخرسانة',style:TextStyle(
                     color: Colors.white,
                     fontSize: 28,
                     fontWeight: FontWeight.w600,
                     letterSpacing: 1.2,
                   ),),
                   Image.asset('images/car.png',
                   width:double.infinity,),
                 ],
               ),
             ],
           ),
           AuthForm(),
         ],
       ),
          ),
        );
  }
}
