import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school/services/auth.dart';

part 'store_data_state.dart';

class StoreDataCubit extends Cubit<StoreDataState> {
  StoreDataCubit() : super(StoreDataInitial());

  Stream? streamStudents;
  String? userEmail;
   var user;

  static StoreDataCubit get(context)=>BlocProvider.of(context);

     sendStudent(String name , String age , DateTime now)
    {
      userEmail=FirebaseAuth.instance.currentUser!.email;
      emit(StoreDataLoadingState());
       Message message=Message(name: name, age: age , time :now,sender: userEmail!);
       FirebaseFirestore.instance.
      collection('students').add(message.toMap()).
      then((value) {
        emit(StoreDataSuccessState());
       }).catchError((error){
         emit(StoreDataErrorState());
       });
    }

        receiveStudent()
        {
         streamStudents= FirebaseFirestore.instance.collection('students').
          orderBy('time').snapshots();
         emit(StoreDataReceiveStudentsState());
        }

    getUserData()
   {
      user=FirebaseAuth.instance.currentUser;
      emit(StoreDataGetUserDataState());
   }
}
