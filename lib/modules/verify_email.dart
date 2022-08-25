
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school/modules/entering_data.dart';
import 'package:school/shared/components/components/original_button.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late bool isemailverified;
  Timer? timer;
   @override
   void initState()
   {
     timer=Timer.periodic(Duration(seconds: 3),
             (timer) {
             checkEmailVerified();
             });
   }
   @override
   void dispose(){
     timer?.cancel;
     super.dispose();
   }

  Future checkEmailVerified()
  async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
     isemailverified=FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isemailverified){
      timer?.cancel;
    }
  }

  @override
  Widget build(BuildContext context) {
     if(isemailverified)
       {
        return EnteringData();
       }
     else {
     return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('تم إرسال رسالة تأكيد الي البريد الإلكترونى'),
              const SizedBox(height: 30),
              OriginalButton(text:'إعادة ارسال الايميل',
                  onpressed:(){
                  },
                  textcolor:Colors.white ,
                  bgcolor:Colors.blueAccent)
            ],
          ),
        ),
      ) ,
    );
     }
  }
}
