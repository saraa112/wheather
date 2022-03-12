import 'package:flutter/material.dart';
import 'package:school/services/auth.dart';
import 'package:school/views/entering_data.dart';
import 'package:school/widgets/original_button.dart';
import '../core/utils/app_naviagtor.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key,}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey =GlobalKey<FormState>();
  String _email='',_password='';
  AuthBase authbase=AuthBase();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child:
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 12,),
           TextFormField(
            onChanged: (value){ _email= value;},
            validator: (value) => value!.isEmpty ? 'ادخل بريد الكتروني صالح للاستخدام':null ,
            decoration: InputDecoration(
            labelText: 'اكتب البريد الالكتروني',
            prefixIcon:Icon(Icons.mail),
          ),
             keyboardType: TextInputType.emailAddress,
          ),
         const SizedBox(height: 12,),
          TextFormField(
          onChanged: (value)=> _password=value,
          validator: (value) => value!.length < 6 ? 'كلمة المرور يجب ان تتكون من 6 علي الاقل ':null  ,
          decoration: InputDecoration(
          labelText: 'اكتب كلمة المرور',
          prefixIcon: Icon(Icons.lock)),
          keyboardType:TextInputType.visiblePassword,
          obscureText: true,
    ),
          const SizedBox(height: 20,),

          OriginalButton(
            text:'تسجيل الدخول',
            onpressed:()async{
              if(_formkey.currentState!.validate())
                {
                  await authbase.signInWithEmailAndPassword(_email, _password);
                  AppNavigator.customNavigator(context: context, screen: EnteringData(), finish:true);
                }
                },
                textcolor: Colors.white,
                bgcolor: Colors.lightBlue,
               ),

          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ليس لديك حساب ؟',style: TextStyle(
                  fontSize: 18
              ),),
              TextButton(
                  onPressed: ()
                        async{
                          if(_formkey.currentState!.validate())
                          {
                            await authbase.registerWithEmailAndPassword(_email, _password);
                            AppNavigator.customNavigator(context: context, screen: EnteringData(), finish:true);
                          }
                    },
                  child: Text('سجل الان',
                    style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 18
                  ),)),
            ],
          )
        ],
      ),
    ));
  }
}
