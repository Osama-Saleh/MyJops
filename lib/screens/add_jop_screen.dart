// ignore_for_file: avoid_unnecessary_containers, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myjob/components.dart';
import 'package:myjob/controller/home_cubit.dart';
import 'package:myjob/controller/home_states.dart';

class AddJopScreen extends StatelessWidget {
  AddJopScreen({super.key});
  var textController = TextEditingController();
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // if (state is CreatPostSuccessState) {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => JopScreen(),
        //       ));
        // }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: 550,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Text(
                              "Create Post",
                              style: TextStyle(fontSize: 25),
                            ),
                            const Spacer(),
                            defaultMaterialButton(
                                onPressed: () {
                                  if (cubit.postImageUrl == null) {
                                    cubit.creatPost(
                                        text: textController.text,
                                        time: now.toString());
                                  } else {
                                    cubit.creatPost(
                                        text: textController.text,
                                        imagePost: "${cubit.lastImagePostUrl}",
                                        time: now.toString());
                                  }
                                  return null;
                                },
                                borderRadius: 4,
                                height: 40,
                                minWidth: 30,
                                color: Colors.blue,
                                widget: const Text("POST"))
                          ],
                        ),
                      ),
                      const Divider(),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: cubit.userModel?.profileImage !=
                                    null
                                ? NetworkImage(cubit.userModel!.profileImage!)
                                : const NetworkImage(
                                        "https://media.istockphoto.com/id/1298261537/vector/blank-man-profile-head-icon-placeholder.jpg?s=612x612&w=0&k=20&c=CeT1RVWZzQDay4t54ookMaFsdi7ZHVFg2Y5v7hxigCA=")
                                    as ImageProvider,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("${cubit.userModel!.name}")
                        ],
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: textController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "What's on you mind?"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "write post";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      if (cubit.postImageUrl != null)
                        Stack(
                          children: [
                            Container(
                              height: 270,
                              width: double.infinity,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Card(
                                child: Image(
                                  image: FileImage(cubit.postImageUrl!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: InkWell(
                                onTap: () {
                                  cubit.removePostImage();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close),
                                ),
                              ),
                            )
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                cubit.getPostImage();
                                print("gallary");
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    // color: Colors.red,
                                    image: DecorationImage(
                                        image:
                                            AssetImage("assets/gallery.png"))),
                              ),
                            ),
                            const Text(
                              "gallary",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
