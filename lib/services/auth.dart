import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
   try{
     final authResult =await  FirebaseAuth.instance.createUserWithEmailAndPassword
       (email: email, password: password);
     return _userFromFirebase(authResult.user);
   }catch(e){
   }
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

    }

