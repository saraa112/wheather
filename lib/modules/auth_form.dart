
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/modules/verify_email.dart';
import 'package:school/services/auth.dart';
import 'package:school/shared/components/components/original_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/store_data/store_data_cubit.dart';
import '../core/toast/toast_config.dart';
import '../core/utils/app_naviagtor.dart';
import '../enums/toast_states.dart';
import '../services/students.dart';
import 'entering_data.dart';



class AuthForm extends StatefulWidget {
  const AuthForm({Key? key,}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formkey = GlobalKey<FormState>();
  String _email = '',
      _password = '';
  AuthBase authbase = AuthBase();
  bool keepMeLoggedIn = false;
  bool ishiddenpassword = true;
  bool isEmailVerified=false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreDataCubit, StoreDataState>
      (listener: (context, state) {},

        builder: (context, state) {
          var cubit = StoreDataCubit.get(context);
          cubit.getUserData();
          return
            Form(
              key: _formkey,
              child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 12,),
                    TextFormField(
                      onChanged: (value) {
                        _email = value;
                      },
                      validator: (value) =>
                      ((value!.isEmpty) && !(value.contains('@')))
                          ? 'ادخل بريد الكتروني صالح للاستخدام'
                          : null,
                      decoration: const InputDecoration(
                        labelText: 'اكتب البريد الالكتروني',
                        prefixIcon: Icon(Icons.mail),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12,),
                    TextFormField(
                      onChanged: (value) => _password = value,
                      validator: (value) =>
                      value!.length < 6
                          ? 'كلمة المرور يجب ان تتكون من 6 علي الاقل '
                          : null,
                      decoration: InputDecoration(
                          labelText: 'اكتب كلمة المرور',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  ishiddenpassword = !ishiddenpassword;
                                });
                              },
                              child: ishiddenpassword
                                  ? Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off))),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: ishiddenpassword,
                    ),
                    const SizedBox(height: 20,),

                    OriginalButton(
                      text: 'تسجيل الدخول',
                      onpressed: () async {
                        if (_formkey.currentState!.validate()) {
                          await authbase.signInWithEmailAndPassword(
                              _email, _password).then((value) async {
                                if(keepMeLoggedIn)
                                  {
                                    SharedPreferences prefs = await SharedPreferences
                                        .getInstance();
                                    prefs.setBool('keepmeloggedin', keepMeLoggedIn);
                                  }

                            isEmailVerified = FirebaseAuth.instance.currentUser!
                                .emailVerified;
                            if (!isEmailVerified) {
                              final user = FirebaseAuth.instance.currentUser;
                              await user?.sendEmailVerification();
                              AppNavigator.customNavigator(context: context,
                                  screen: const VerifyEmail(),
                                  finish: true);
                                }

                              if (FirebaseAuth.instance.currentUser?.email ==
                                  'ahmedelkyal1@gmail.com') {
                                AppNavigator.customNavigator(context: context,
                                    screen: Students(sreeamStudents:cubit.streamStudents,
                                                     userMail: cubit.user!.email)
                                                    , finish: true);}
                              else {
                                AppNavigator.customNavigator(context: context,
                                    screen: EnteringData(),
                                    finish: true);}
                            }
                          );
                        }
                      },
                      textcolor: Colors.white,
                      bgcolor: Colors.lightBlue,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('تذكرني ؟'),
                        Checkbox(
                            value: keepMeLoggedIn,
                            onChanged: (value) {
                              setState(() async {
                                keepMeLoggedIn = value!;
                              });
                            }),
                      ],
                    ),

                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('هل نسيت كلمة المرور ؟', style: TextStyle(
                            fontSize: 18
                        ),),
                        TextButton(
                            onPressed: () {
                              resetPassword();
                            },
                            child: const Text('إعادة تعيين',
                              style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 18
                              ),)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('ليس لديك حساب ؟', style: TextStyle(
                            fontSize: 18
                        ),),
                        TextButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                await authbase.registerWithEmailAndPassword(
                                    _email, _password);
                                AppNavigator.customNavigator(context: context,
                                    screen: EnteringData(),
                                    finish: false);
                              }
                            },
                            child: const Text('سجل الان',
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
        );
  }
  Future resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _email)
        .then((value) {
      ToastConfig.showToast(msg:'تم الارسال',
          toastStates: ToastStates.Success);}
     ).catchError((error){
       print('error is ${error.toString()}');
    });
  }
}
