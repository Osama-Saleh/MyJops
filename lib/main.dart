// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myjob/components.dart';
import 'package:myjob/controller/home_cubit.dart';
import 'package:myjob/controller/home_states.dart';
import 'package:myjob/screens/home_screen.dart';
import 'package:myjob/screens/login_Screen.dart';
import 'package:myjob/shared/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreference.initialSharedPreference();
  await Firebase.initializeApp();

  uidUser = SharedPreference.getDataSt(key: "uid");
  print("uidUser $uidUser");
  Widget firstScreen;
  if (uidUser != null) {
    firstScreen = HomeScreen();
  } else {
    firstScreen = LoginScreen();
  }
  runApp(MyApp(
    screen: firstScreen,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.screen});
  Widget? screen;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getUserData()
        ..getAllPosts(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: screen,
          );
        },
      ),
    );
  }
}