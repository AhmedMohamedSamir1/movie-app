// ignore_for_file: sized_box_for_whitespace, use_key_in_widget_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:movie_app/modules/login/login_screen.dart';
import 'package:movie_app/modules/register/states.dart';
import 'package:movie_app/movie_layout/movie_layout_screen.dart';
import 'package:movie_app/shared/components/basics.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/cash_helper.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import 'cubit.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return MovieRegisterCubit();
      },
      child: BlocConsumer<MovieRegisterCubit, MovieRegisterStates>(
        listener: (context, state) {
          if (state is MovieRegisterSuccessState) {
            CashHelper.saveData(key: 'email', value: state.email.toString());
            CashHelper.saveData(key: 'password', value: state.password.toString());
            EMAIL = state.email;
            PASSWORD = state.password;
            navigateAndFinish(context, LoginScreen());

          }
        },
        builder: (context, state) {
          var cubit = MovieRegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'Registration',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Text(
                      'login now to reserve tickets and enjoy watching the enjoyable movies',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.grey[800]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultTextFormField(
                            fieldController: nameController,
                            inputType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "name can't be empty";
                              }
                            },
                            labelText: 'Name',
                            prefixIcon: Icons.person,
                            borderRadius: 15,
                            elevation: 5,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultTextFormField(
                            fieldController: emailController,
                            inputType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "email can't be empty";
                              }
                            },
                            labelText: 'Email',
                            prefixIcon: Icons.email_outlined,
                            borderRadius: 15,
                            elevation: 5,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultTextFormField(
                              fieldController: passwordController,
                              inputType: TextInputType.visiblePassword,
                              obscureText: cubit.passVisibility,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "password can't be empty";
                                }
                              },
                              labelText: 'Password',
                              prefixIcon: Icons.lock_outlined,
                              suffixIcon: cubit.passVisibilityIcon,
                              suffixClicked: () {
                                cubit.changePassVisibility();
                              },
                              borderRadius: 15,
                              elevation: 5),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultTextFormField(
                              fieldController: confirmPasswordController,
                              inputType: TextInputType.visiblePassword,
                              obscureText: cubit.confirmPassVisibility,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "password can't be empty";
                                }
                                if (confirmPasswordController.text !=
                                    passwordController.text) {
                                  return "password must be identical";
                                }
                              },
                              labelText: 'Confirm Password',
                              prefixIcon: Icons.lock_outlined,
                              suffixIcon: cubit.confirmPassVisibilityIcon,
                              suffixClicked: () {
                                cubit.changeConfirmPassVisibility();
                              },
                              borderRadius: 15,
                              elevation: 5),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultTextFormField(
                              fieldController: phoneController,
                              inputType: TextInputType.phone,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "phone can't be empty";
                                }
                              },
                              labelText: 'Phone',
                              prefixIcon: Icons.phone,
                              borderRadius: 15,
                              elevation: 5),
                          const SizedBox(
                            height: 15,
                          ),
                          Conditional.single(
                              context: context,
                              conditionBuilder: (context) =>
                                  state is! MovieRegisterLoadingState,
                              widgetBuilder: (context) => defaultMaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.registerByEmailAndPass(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  text: 'Register',
                                  radius: 15,
                                  gradientColorsList: [
                                    Colors.blue,
                                    Colors.blue.withOpacity(0.5)
                                  ],
                                  boxShadowColor: Colors.blue),
                              fallbackBuilder: (context) => Container(
                                    height: 20,
                                    child: LoadingBouncingLine.circle(
                                      borderColor: Colors.blue,
                                      backgroundColor: Colors.blue,
                                      borderSize: 3.0,
                                      size: 80.0,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                    ),
                                  )),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
