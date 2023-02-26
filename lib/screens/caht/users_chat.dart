// ignore_for_file: prefer_const_constructors, prefer_is_empty, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myjob/controller/home_cubit.dart';
import 'package:myjob/controller/home_states.dart';
import 'package:myjob/module/user_model.dart';
import 'package:myjob/screens/caht/chattig_screen.dart';

class UsersChat extends StatefulWidget {
  const UsersChat({super.key});

  @override
  State<UsersChat> createState() => _UsersChatState();
}

class _UsersChatState extends State<UsersChat> {

  @override
  void initState() {
    super.initState();
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    // messaging.getToken().then((value) {
    //   print("devise token  is : $value");
    // }).catchError((error) {
    //   print("Error not have device token");
    // });
  }
  
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      // HomeCubit.get(context).getAllUser();
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: ConditionalBuilder(
            condition: HomeCubit.get(context).users.length > 0,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildUser(context, HomeCubit.get(context).users[index]),
                separatorBuilder: (context, index) => Divider(),
                itemCount: HomeCubit.get(context).users.length),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ));
        },
      );
    });
  }
}

Widget buildUser(context, UserModel model) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChattingScreen(
                    model: model,
                  )));

      print("Click user");
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("${model.profileImage}"),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text("${model.name}"),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
