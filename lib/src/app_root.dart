import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:school/blocs/store_data/store_data_cubit.dart';
import 'package:school/modules/auth_view.dart';


class AppRoot extends StatelessWidget {

  bool isUserLoggedIn=false;
  @override
  Widget build(BuildContext context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context)=>StoreDataCubit()..receiveStudent())
              ],
              child: MaterialApp(
                home:AuthScreen() ,
                debugShowCheckedModeBanner: false,
                theme:ThemeData(
                    fontFamily: 'Mada',
                    inputDecorationTheme:InputDecorationTheme(
                      filled: true,
                      fillColor: const Color(0xfff2f9fe),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.blue),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      disabledBorder:OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blue,),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blue,),
                          borderRadius: BorderRadius.circular(20)
                      ),
                    )
                ),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('ar', ''), // English, no country code
                ],
              ),
            );
          }
        }
