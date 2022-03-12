import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather/bloc/autogen_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


        return Scaffold(
          body:BlocConsumer<AutogenCubit,AutogenState>(
            listener:(context,State){} ,
            builder:(context,State) {
              var cubit = AutogenCubit.get(context);

              return ListView.builder(
                itemCount: cubit.articles.length,
                scrollDirection: Axis.vertical
                , itemBuilder: (context, index) {
                return Container(
                  child: Text(cubit.articles[index].content.toString()),
                );
              },
              );
            }
            )
        );

      }
      }



