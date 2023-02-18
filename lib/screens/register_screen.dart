// ignore_for_file: prefer_const_constructors, missing_required_param, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myjob/components.dart';
import 'package:myjob/controller/home_cubit.dart';
import 'package:myjob/controller/home_states.dart';
import 'package:myjob/screens/login_Screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var phoneCotroller = TextEditingController();
  var mailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is CreatUserSuccessState) {
            
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.teal,
            // appBar: AppBar(
            //   backgroundColor: Colors.teal,
            //   elevation: 0,
            // ),
            body: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Register Now",
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        defaultTextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your data";
                            }
                            return null;
                          },
                          hintText: "Enter Your Name",
                          keyboardType: TextInputType.text,
                          radius: 10,
                          prefixIcon: Icon(Icons.person),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: phoneCotroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your Phone";
                            }
                            return null;
                          },
                          hintText: "Phone number",
                          keyboardType: TextInputType.number,
                          radius: 10,
                          prefixIcon: Icon(Icons.phone),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: mailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your data";
                            }
                            return null;
                          },
                          hintText: "Enter Your Name",
                          keyboardType: TextInputType.emailAddress,
                          radius: 10,
                          prefixIcon: Icon(Icons.mail),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your data";
                            }
                            return null;
                          },
                          hintText: "Enter Your Password",
                          keyboardType: TextInputType.number,
                          radius: 10,
                          obscureText: cubit.showPassword,
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.ChangePasswordVisibility();
                            },
                            icon: Icon(cubit.suffix),
                          ),

                          // obscureText: true,
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                defaultMaterialButton(
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        HomeCubit.get(context).registerUser(
                                          emailAddress: mailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneCotroller.text,
                                        );
                                        
                                      }
                                      return null;
                                    },
                                    widget: Text("Sign Up"),
                                    borderRadius: 10,
                                    color: Colors.amber),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Already have an Account",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen(),
                                              ));
                                        },
                                        child: Text(
                                          "Log in",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.cyan,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
