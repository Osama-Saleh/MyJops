// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myjob/controller/home_cubit.dart';
import 'package:myjob/controller/home_states.dart';
import 'package:myjob/module/chat_model.dart';
import 'package:myjob/module/user_model.dart';
// import 'package:myjob/screens/caht/users_chat.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChattingScreen extends StatefulWidget {
  UserModel? model;

  ChattingScreen({this.model});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  String textController = "";

  String? text;

  

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      HomeCubit.get(context).getMessage(receiverId: widget.model!.uid);
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              // backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage("${widget.model!.profileImage}"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${widget.model!.name}",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              // leading: IconButton(
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => UsersChat(),
              //         ));
              //   },
              //   icon: Icon(
              //     Icons.arrow_back,
              //     size: 30,
              //     color: Colors.black,
              //   ),
              // ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage("${widget.model!.profileImage}"),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("${widget.model!.name}")
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            if (HomeCubit.get(context).userModel!.uid ==
                                HomeCubit.get(context).message[index].SenderId)
                              return buildMyMessage(
                                  HomeCubit.get(context).message[index]);

                            return buildMessage(
                                HomeCubit.get(context).message[index]);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 5,
                              ),
                          itemCount: HomeCubit.get(context).message.length),
                    ),
                  ),
                  // Spacer(),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        )),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            // controller: textController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Your Message";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              // setState(() {
                              //   text = value;
                              // });
                              HomeCubit.get(context)
                                  .changTextMessage(value.toString());
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write Your Message.."),
                          ),
                        ),
                        Spacer(),
                        MaterialButton(
                          onPressed: () async {
                            await HomeCubit.get(context).creatChatting(
                              dateTime: DateTime.now().toString(),
                              receiverId: widget.model!.uid,
                              text:
                                  HomeCubit.get(context).textMessage.toString(),
                            );
                            print(
                                "Message : ${HomeCubit.get(context).textMessage.toString()}");
                          },
                          color: Colors.blue,
                          minWidth: 50,
                          height: 50,
                          child: Icon(Icons.send),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

Widget buildMessage(ChatModel message) {
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text("${message.text}"),
      ),
    ),
  );
}

Widget buildMyMessage(ChatModel message) {
  return Align(
    alignment: Alignment.topRight,
    child: Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 183, 243, 127),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text("${message.text}"),
      ),
    ),
  );
}
