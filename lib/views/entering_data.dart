import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/blocs/store_data/store_data_cubit.dart';
import 'package:school/widgets/original_button.dart';

import '../services/students.dart';

class EnteringData extends StatelessWidget {

    var namecontroller=TextEditingController();
    var agecontroller=TextEditingController();
    bool x=true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreDataCubit,StoreDataState>
      ( listener:(context,state){},

         builder:(context,state){
         var cubit=StoreDataCubit.get(context);
            cubit.getUserData();
        return Scaffold(
           backgroundColor: Colors.grey,
            appBar:AppBar(
              title:Text('استمارة التقديم'),
            ),

            body: Container(
              child:Form(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(

                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height *0.1,
                      ),

                      TextFormField(
                        controller: namecontroller,
                        decoration: InputDecoration(
                            labelText:' اكـــتـــب  الاســم '
                        ),
                      ),

                      TextFormField(
                        controller: agecontroller,
                        decoration: InputDecoration(
                            labelText:'الســـن '
                        ),
                      ),

                      OriginalButton(
                          text: 'حفظ',
                          onpressed: (){
                            DateTime now=DateTime.now();
                           cubit.sendStudent(namecontroller.text, agecontroller.text,now);
                            },
                          textcolor: Colors.white,
                          bgcolor: Colors.lightBlue),
                            if(cubit.user.email=='malek@gmail.com')
                          Students(sreeamStudents: cubit.streamStudents,
                                   userMail: cubit.user!.email ),
                    ],
                  ),
                ),
              ) ,
            ),

        );
    });
  }
}
