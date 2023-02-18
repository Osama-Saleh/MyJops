// ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore, missing_required_param, must_be_immutable, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myjob/components.dart';
import 'package:myjob/controller/home_cubit.dart';
import 'package:myjob/controller/home_states.dart';
import 'package:myjob/screens/home_screen.dart';
import 'package:myjob/screens/register_screen.dart';
import 'package:myjob/shared/shared_pref.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var mailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    // ignore: prefer_const_constructors
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) async {
        if (state is LoginUserSuccessState) {
          await SharedPreference.saveDate(key: "uid", value: state.user_id);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
          // if (state.user_id != null) {
          //   HomeCubit.get(context).getUserData();
          // }
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.teal,
            appBar: AppBar(
              backgroundColor: Colors.teal,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      defaultTextFormField(
                        controller: mailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your data";
                          }
                          return null;
                        },
                        hintText: "Enter Your Mail",
                        keyboardType: TextInputType.emailAddress,
                        radius: 10,
                        prefixIcon: Icon(Icons.mail),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
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
                          defaultMaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                HomeCubit.get(context).loginUser(
                                    emailAddress: mailController.text,
                                    password: passwordController.text,
                                  );
                                }
                                return null;
                              },
                              widget: Text("Login"),
                              borderRadius: 10,
                              color: Colors.amber),
                        ],
                      ),
                      SizedBox(
                        height: 90,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create Account",
                            style: TextStyle(fontSize: 20),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ));
                              },
                              child: Text("REGISTER",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Colors.cyan,
                                          fontWeight: FontWeight.bold)))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
