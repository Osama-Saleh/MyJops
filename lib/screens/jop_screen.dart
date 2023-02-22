// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, duplicate_ignore, avoid_unnecessary_containers, missing_required_param, must_be_immutable, sized_box_for_whitespace, avoid_single_cascade_in_expression_statements, unnecessary_cast, avoid_print, prefer_is_empty

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myjob/components.dart';
import 'package:myjob/controller/home_cubit.dart';
import 'package:myjob/controller/home_states.dart';
import 'package:myjob/module/post_model.dart';
import 'package:myjob/module/user_model.dart';

class JopScreen extends StatefulWidget {
  const JopScreen({super.key});

  @override
  State<JopScreen> createState() => _JopScreenState();
}

class _JopScreenState extends State<JopScreen> {
  // JopScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: ConditionalBuilder(
          condition: HomeCubit.get(context).posts.length > 0 &&
              HomeCubit.get(context).userModel != null,
          builder: (context) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return buildItems(
                    context, HomeCubit.get(context).posts[index], index);
              },
              itemCount: HomeCubit.get(context).posts.length,
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ));
      },
    );
  }
}

Widget buildDialog(context, UserModel userModel, PostModel postModel) {
  return Container(
    height: 80,
    width: MediaQuery.of(context).size.width,
    child: Card(
        margin: EdgeInsets.all(5),
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: userModel.profileImage != null
                  ? NetworkImage(userModel.profileImage!)
                  : NetworkImage("assets/default.jpg") as ImageProvider,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 50,
                child: MaterialButton(
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.bottomSlide,
                      dialogType: DialogType.noHeader,
                      body: Container(
                        height: 590,
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_back,
                                        size: 20,
                                      ),
                                    ),
                                    Text("Create Post"),
                                    Spacer(),
                                    defaultMaterialButton(
                                        onPressed: () {
                                          return null;

                                          // cubit.creatPost(225566)
                                        },
                                        borderRadius: 4,
                                        height: 40,
                                        minWidth: 30,
                                        color: Colors.blue,
                                        widget: Text("POST"))
                                  ],
                                ),
                                Divider(),
                                Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: userModel.profileImage !=
                                              null
                                          ? NetworkImage(
                                              userModel.profileImage!)
                                          : NetworkImage(
                                                  "https://media.istockphoto.com/id/1298261537/vector/blank-man-profile-head-icon-placeholder.jpg?s=612x612&w=0&k=20&c=CeT1RVWZzQDay4t54ookMaFsdi7ZHVFg2Y5v7hxigCA=")
                                              as ImageProvider,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("${userModel.name}")
                                  ],
                                ),
                                Expanded(
                                  child: TextFormField(
                                    // controller: textController,
                                    decoration: InputDecoration(
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
                                if (HomeCubit.get(context).postImageUrl != null)
                                  Stack(
                                    children: [
                                      Container(
                                        height: 300,
                                        width: double.infinity,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Card(
                                          child: Image(
                                            image: FileImage(
                                                    HomeCubit.get(context)
                                                        .postImageUrl!)
                                                as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: InkWell(
                                          onTap: () {
                                            HomeCubit.get(context)
                                                .removePostImage();
                                          },
                                          child: CircleAvatar(
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
                                          HomeCubit.get(context).getPostImage();
                                          print("gallary");
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/gallery.png"))),
                                        ),
                                      ),
                                      Text(
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
                    )..show();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "What's on Your mind?",
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.black.withAlpha(60))),
                ),
              ),
            ),
          ],
        )),
  );
}

Widget buildItems(context, PostModel postModel, index) {
  var commentController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  // var cubit = HomeCubit.get(context);
  // return ListView.builder(
  //   physics: NeverScrollableScrollPhysics(),
  //   shrinkWrap: true,
  //   itemBuilder: (context, index) {
  return Container(
    child: Form(
      key: formkey,
      child: Column(
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          NetworkImage("${postModel.imageProfile}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text("${postModel.name}"),
                          SizedBox(
                            height: 5,
                          ),
                          Text(postModel.dateTime.toString()),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey[500],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      "${postModel.text}",
                      style: TextStyle(height: 1.3, fontSize: 20),
                    ),
                  ),
                ),
                if (postModel.imagepost != null)
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Card(
                      child: Image(
                        width: double.infinity,
                        image: NetworkImage("${postModel.imagepost}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          await HomeCubit.get(context)
                              .likePost(HomeCubit.get(context).postsId[index]);
                          // await  HomeCubit.get(context).getAllPosts();
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.favorite_border),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  "${HomeCubit.get(context).countLikes[index].toString()} Like")
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.comment),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  "${HomeCubit.get(context).countComments[index]} Comments")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            "${HomeCubit.get(context).userModel!.profileImage}"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: defaultTextFormField(
                          controller: commentController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "No Comment";
                            }
                            return null;
                          },
                          hintText: "Write Comment...",
                          radius: 50,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      defaultMaterialButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                          HomeCubit.get(context).commentPosts(
                              HomeCubit.get(context).postsId[index],
                              commentController.text);
                          // HomeCubit.get(context).getComments();
                          }
                          return null;
                        },
                        minWidth: 0,
                        color: Colors.white,
                        widget: Icon(
                          Icons.send_rounded,
                          size: 30,
                        ),
                        borderRadius: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
            margin: EdgeInsets.all(8),
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
          ),
        ],
      ),
    ),
  );
}
    // },
    // itemCount: 3,
  // );
// }
