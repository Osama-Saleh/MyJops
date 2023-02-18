// ignore_for_file: missing_required_param, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myjob/components.dart';
import 'package:myjob/controller/home_cubit.dart';
import 'package:myjob/controller/home_states.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: defaultTextFormField(
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
          );
        });
  }
}
