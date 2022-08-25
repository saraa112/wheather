
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school/blocs/store_data/store_data_cubit.dart';
import 'package:school/shared/components/components/original_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import '../core/utils/app_naviagtor.dart';
import '../services/auth.dart';
import '../services/students.dart';
import 'auth_view.dart';

class EnteringData extends StatefulWidget {

  @override
  State<EnteringData> createState() => _EnteringDataState();

}
class _EnteringDataState extends State<EnteringData> {
    var namecontroller=TextEditingController();
    var phonecontroller=TextEditingController();
    var volumcontroller=TextEditingController();

    var selectedcaliber='عيار1';
    var selectedcement='اسمنت 1';
    var selectedeffort='الجهد1';
    var selectedtype='سقف';

     DateTime date=DateTime.now();
     String datetext='اختر تاريخ الصبة';

     TimeOfDay time=TimeOfDay.now();
     String timetext='اخترالتوقيت ';
    AuthBase authbase = AuthBase();

    //var fbn=FirebaseMessaging.instance;
   // sendNotify(String title,String body,String id)
   // async{
    //  }
  //  @override
  //  void initState() {
    //  fbn.getToken().then((token) {
      //  FirebaseFirestore.instance.collection('tokens').
      //  add({
       //   "token":token
      //  });
       // print(token);
      //  print('-------------------------------');
     // });
     // FirebaseMessaging.onMessageOpenedApp.listen((message) {
        // AppNavigator.customNavigator(context: context,
        //  screen: Students(sreeamStudents:cubit.streamStudents,
        //  userMail: cubit.user!.email),
        //  finish: true);
     // });
     // FirebaseMessaging.onMessage.listen((event) {
       // print('-----notification is---------');
       // print('${event.notification!.body}');
       // AwesomeDialog(context: context,title: '',body: Text('${event.notification!.body}')).show();
         // AppNavigator.customNavigator(context: context,
         //  screen: Students(sreeamStudents:cubit.streamStudents,
         //  userMail: cubit.user!.email),
        //  finish: true);
     // });
     // super.initState();
    //}

    @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreDataCubit,StoreDataState>
      ( listener:(context,state){},

         builder:(context,state){
         var cubit=StoreDataCubit.get(context);
            cubit.getUserData();
        return Scaffold(
            appBar:AppBar(
              actions: [
                IconButton(
                  onPressed:()async{
                    SharedPreferences prefs=await SharedPreferences.getInstance();
                    prefs.clear();
                    authbase.logOut();
                    AppNavigator.customNavigator(context: context, screen:AuthScreen(), finish:true);
                  } ,
                  icon: const Icon(Icons.logout),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border:Border.all(color: Colors.white),
                  ),

                  child: IconButton(
                    onPressed:(){
                      SystemNavigator.pop();
                      },
                      icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),

            body: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex:7,
                    child: SingleChildScrollView(
                      child: Container(
                        child:Form(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                             // crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: namecontroller,
                                  decoration: const InputDecoration(
                                      labelText:' اكـــتـــب  الاســم ',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: phonecontroller,
                                  decoration: const InputDecoration(
                                      labelText:'رقم الهاتف '
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: volumcontroller,
                                  decoration: const InputDecoration(
                                      labelText:' اكـــتـــب  حجم الصبة بالمتر '
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.white,
                                          border:Border.all(color: Colors.blue)
                                            ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: const Text('اختر العيار'),
                                          value: selectedcaliber,
                                          items:
                                          ['عيار1','عيار2','عيار3'].map((e) =>
                                              DropdownMenuItem(child: Text(e),value: e)).toList(),
                                          onChanged: (value)
                                          {
                                            setState(() {
                                              selectedcaliber=value.toString();
                                            });
                                          }
                                          ,borderRadius: BorderRadius.circular(20),
                                          style:const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 20,
                                            fontFamily: 'Mada'
                                          ) ,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Container(
                                      decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white,
                                          border:Border.all(color: Colors.blue)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: const Text('اخترنوع الأسمنت'),
                                          value: selectedcement,
                                          items:
                                          ['اسمنت 1','أسمنت2','أسمنت3'].map((e) =>
                                              DropdownMenuItem(child: Text(e),value: e)).toList(),
                                          onChanged: (value)
                                          {
                                            setState(() {
                                              selectedcement=value.toString();
                                            });
                                          }
                                          ,borderRadius: BorderRadius.circular(20),
                                          style:const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 20,
                                            fontFamily: 'Mada'
                                          ) ,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white,
                                          border:Border.all(color: Colors.blue)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: const Text('اخترنوع الجهد'),
                                          value: selectedeffort,
                                          items:
                                          ['الجهد3','الجهد2','الجهد1'].map((e) =>
                                              DropdownMenuItem(child: Text(e),value: e)).toList(),
                                          onChanged: (value)
                                          {
                                            setState(() {
                                              selectedeffort=value.toString();
                                            });
                                          }
                                          ,borderRadius: BorderRadius.circular(20),
                                          style:const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 20,
                                            fontFamily: 'Mada'
                                          ) ,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width :30),
                                    Container(
                                      decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white,
                                          border:Border.all(color: Colors.blue)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: const Text('اخترنوع الصبة',
                                          ),
                                          value: selectedtype,
                                          items:
                                          ['خرسانة','أعمدة','سقف'].map((e) =>
                                              DropdownMenuItem(child: Text(e),value: e)).toList(),
                                          onChanged: (value)
                                          {
                                            setState(() {
                                              selectedtype=value.toString();
                                            });
                                          }
                                          ,borderRadius:BorderRadius.circular(20),
                                          style:const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 20,
                                            fontFamily: 'Mada'
                                          ) ,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration:BoxDecoration(
                                       borderRadius: BorderRadius.circular(20),
                                        color: Colors.white
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(onPressed: ()
                                        async
                                        {
                                        DateTime? newdate=await
                                        showDatePicker(
                                        context: context,
                                        initialDate: date,
                                        firstDate: date,
                                        lastDate: DateTime(2023),
                                        );
                                        if(newdate==null)return;
                                        setState(() {
                                          date=newdate;
                                          datetext=DateFormat.yMMMd().format(date) ;
                                        });
                                        } ,
                                              icon:const Icon(Icons.calendar_today) ),
                                          Text('$datetext'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 30),
                                    Container(
                                      decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(onPressed: ()
                                           async
                                             {
                                         TimeOfDay? newtime=await
                                            showTimePicker(context: context,
                                             initialTime: time);
                                           if(newtime==null)return;
                                               setState(() {
                                                time=newtime;
                                                timetext=time.format(context);
                                                 });
                                                } ,
                                              icon:const Icon(Icons.watch) ),
                                          Text('$timetext'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ) ,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                      child: OriginalButton(
                          text: 'حفظ',
                          onpressed: ()
                          async{
                            DateTime now=DateTime.now();
                            await cubit.sendData(namecontroller.text, phonecontroller.text,now,
                                          selectedcaliber,selectedcement,selectedeffort,
                                           datetext,timetext ,volumcontroller.text,selectedtype);
                                        },
                          textcolor: Colors.white,
                          bgcolor: Colors.lightBlue),
                    ),
                  )
                ],
              ),
            ),);
    });
  }
}
