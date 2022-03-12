import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:school/blocs/store_data/store_data_cubit.dart';

import '../views/auth_view.dart';


class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
        BlocProvider(create: (context)=>StoreDataCubit()..receiveStudent())
        ],
      child: MaterialApp(
        home:AuthScreen() ,
        debugShowCheckedModeBanner: false,
        theme:ThemeData(
            inputDecorationTheme:InputDecorationTheme(
              filled: true,
              fillColor: Color(0xfff2f9fe),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,),
                  borderRadius: BorderRadius.circular(20)
              ),
              disabledBorder:OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,),
                  borderRadius: BorderRadius.circular(20)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,),
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
