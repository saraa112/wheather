
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school/core/utils/app_naviagtor.dart';
import 'package:school/modules/auth_form.dart';
import 'package:school/modules/auth_view.dart';
import 'package:school/modules/entering_data.dart';
import 'package:school/modules/verify_email.dart';
 class MyUser
 {
   final String userId;
   MyUser({required this.userId});
 }

 class AuthBase
 {

    MyUser _userFromFirebase( var user)
    {
      return MyUser(userId:user.uid );
    }

   Future<MyUser?> registerWithEmailAndPassword(String email,String password)
   async{
     final authResult =await  FirebaseAuth.instance.createUserWithEmailAndPassword
                              (email: email, password: password);
         return _userFromFirebase(authResult.user);
         }

    Future<MyUser> signInWithEmailAndPassword(String email,String password)
    async{

      final authResult =await  FirebaseAuth.instance.signInWithEmailAndPassword
        (email: email, password: password);
      return _userFromFirebase(authResult.user);
         }

    Future<void> logOut()
   async{
     await FirebaseAuth.instance.signOut();
        }

   verifyEmail()
   async{
      final user=FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
   }
    }

