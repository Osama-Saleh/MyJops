// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myjob/controller/home_cubit.dart';
import 'package:myjob/controller/home_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                "${HomeCubit.get(context).titleScreen[HomeCubit.get(context).currenIndex]}"),
          ),
          body: HomeCubit.get(context)
              .listScreens[HomeCubit.get(context).currenIndex],
          bottomNavigationBar: CurvedNavigationBar(
            // backgroundColor: Colors.blueAccent,
            height: MediaQuery.of(context).size.height / 14,
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              Image.asset(
                "assets/job.png",
                width: 30,
                height: 30,
              ),
              Image.asset(
                "assets/addjob.png",
                width: 30,
                height: 30,
              ),
              Image.asset(
                "assets/chat.png",
                width: 30,
                height: 30,
              ),
              Image.asset(
                "assets/setting.png",
                width: 30,
                height: 30,
              ),
            ],
            onTap: (value) {
              HomeCubit.get(context).changeButtonBar(value);
            },
            index: HomeCubit.get(context).currenIndex,
          ),
        );
      },
    );
  }
}
