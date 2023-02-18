// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, missing_required_param, avoid_single_cascade_in_expression_statements, sized_box_for_whitespace, must_be_immutable, avoid_print, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myjob/components.dart';
import 'package:myjob/controller/home_cubit.dart';
import 'package:myjob/controller/home_states.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var bioCotroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (contextt, state) {},
      builder: (context, state) {
        return Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              if (state is updateUserDataSuccessState)
                LinearProgressIndicator(),
              Container(
                height: 200,
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: cubit.userModel?.coverImage != null
                              ? NetworkImage(cubit.userModel!.coverImage!)
                              : NetworkImage(
                                      "https://media.istockphoto.com/id/1298261537/vector/blank-man-profile-head-icon-placeholder.jpg?s=612x612&w=0&k=20&c=CeT1RVWZzQDay4t54ookMaFsdi7ZHVFg2Y5v7hxigCA=")
                                  as ImageProvider,
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 18,
                          child: IconButton(
                              iconSize: 23,
                              onPressed: () {
                                cubit.getCoverImage();
                              },
                              icon: Icon(Icons.camera_alt_outlined)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: cubit.userModel?.profileImage != null
                          ? NetworkImage(cubit.userModel!.profileImage!)
                          : NetworkImage(
                                  "https://media.istockphoto.com/id/1298261537/vector/blank-man-profile-head-icon-placeholder.jpg?s=612x612&w=0&k=20&c=CeT1RVWZzQDay4t54ookMaFsdi7ZHVFg2Y5v7hxigCA=")
                              as ImageProvider,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 15,
                          child: IconButton(
                              iconSize: 17,
                              onPressed: () async {
                                await cubit.getImageProfile();
                                // await cubit.uploadProfileImage();
                              },
                              icon: Icon(Icons.camera_alt_outlined)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${HomeCubit.get(context).userModel!.name}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // if (cubit.userModel!.bio != " ")
                        //   SizedBox(
                        //     height: 5,
                        //   ),
                        if (cubit.userModel!.bio == "") Text("Write bio.."),
                        if (cubit.userModel!.bio != "")
                          Text(
                            "${HomeCubit.get(context).userModel!.bio}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.noHeader,
                          body: Container(
                            height: 310,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      defaultTextFormField(
                                        controller: nameController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            print("Enter You Name");
                                          }
                                          return null;
                                        },
                                        hintText: "Your Name",
                                        prefixIcon: Icon(Icons.person),
                                        radius: 10,
                                        keyboardType: TextInputType.name,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      defaultTextFormField(
                                        controller: phoneController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            print("Enter You phone");
                                          }
                                          return null;
                                        },
                                        hintText: "Your Phone",
                                        prefixIcon: Icon(Icons.phone),
                                        radius: 10,
                                        keyboardType: TextInputType.number,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      defaultTextFormField(
                                        controller: bioCotroller,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            print("Enter You bio");
                                          }
                                          return null;
                                        },
                                        hintText: "Your bio",
                                        prefixIcon: Icon(Icons.book),
                                        radius: 10,
                                        keyboardType: TextInputType.text,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      // ignore: prefer_const_literals_to_create_immutables
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          defaultMaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              return null;
                                            },
                                            borderRadius: 10,
                                            color: Colors.red,
                                            widget: Text("Cancle"),
                                          ),
                                          defaultMaterialButton(
                                            onPressed: () {
                                              HomeCubit.get(context)
                                                  .updateUserData(
                                                      name: nameController.text,
                                                      phone:
                                                          phoneController.text,
                                                      bio: bioCotroller.text);

                                              Navigator.pop(context);
                                              

                                              return null;
                                            },
                                            borderRadius: 10,
                                            color: Colors.blue,
                                            widget: Text("Update"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: -15,
                                  top: -25,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Icon(Icons.close),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )..show();
                      },
                      child: Icon(Icons.edit),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
              ),
              Text(
                "Phone",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${HomeCubit.get(context).userModel!.phone}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
