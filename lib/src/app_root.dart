import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather/bloc/autogen_cubit.dart';
import 'package:wheather/views/home_view.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>AutogenCubit()),
      ],
      child: const MaterialApp(
        home: HomeView(),
      ),
    );
  }
}
