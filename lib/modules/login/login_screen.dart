// ignore_for_file: sized_box_for_whitespace, use_key_in_widget_constructors, avoid_print, curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:movie_app/modules/login/states.dart';
import 'package:movie_app/modules/register/register_screen.dart';
import 'package:movie_app/movie_layout/movie_layout_screen.dart';
import 'package:movie_app/shared/components/basics.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/cash_helper.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'cubit.dart';



// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey <FormState> formKey = GlobalKey<FormState>();
  bool tokenApproved = false;

  @override
  Widget build(BuildContext context)
  {

    return BlocProvider(
      create: (BuildContext context) { return MovieLoginCubit();},
      child: BlocConsumer<MovieLoginCubit, MovieLoginStates>(
        listener: (context, state){

          if(state is MovieLoginSuccessState) {

            if(tokenApproved==false) {
              showStylishDialog(context);
            }

            else
              {
              CashHelper.saveData(key: 'token', value: TOKEN);
              CashHelper.saveData(key: 'email', value: state.email);
              CashHelper.saveData(key: 'password', value: state.password);
              EMAIL = state.email;
              PASSWORD = state.password;
              navigateAndFinish(context, MovieLayoutScreen( email: state.email, password: state.password));
            }

          }
        },
        builder: (context, state){

          var cubit = MovieLoginCubit.get(context);
          if(EMAIL!=null){
            emailController.text = EMAIL!;
            passwordController.text = PASSWORD!;
          }
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children:  [
                        Container
                          (
                          height: MediaQuery.of(context).size.height*0.38,
                          child: const Image(
                            image: AssetImage("assets/images/login2.jpg"),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 15,),

                        Text(
                          'login now to reserve tickets and enjoy watching the competitive matches',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey[800]
                          ),
                        ),

                        const SizedBox(height: 15,),

                        Column(
                          children: [
                            const SizedBox(height: 5,),
                            defaultTextFormField(
                              fieldController: emailController,
                              inputType: TextInputType.emailAddress,
                              validator: (String? value){
                                if(value!.isEmpty)
                                  return "email can't be empty";
                              },
                              labelText: 'Email',
                              prefixIcon: Icons.email_outlined,
                              borderRadius: 15,
                              elevation: 5,

                            ),

                            const SizedBox(height: 15,),

                            defaultTextFormField(
                              fieldController: passwordController,
                              inputType: TextInputType.visiblePassword,
                              validator: (String? value){
                                if(value!.isEmpty)
                                  return "password can't be empty";
                              },
                              labelText: 'password',
                              prefixIcon: Icons.lock_outlined,
                              suffixIcon: cubit.passVisibilityIcon,
                              suffixClicked: (){
                                cubit.changePassVisibility();
                              },
                              borderRadius: 15,
                              elevation: 5,
                              obscureText: cubit.passVisibility,
                            ),
                            const SizedBox(height: 15,),

                            Conditional.single(
                                context: context,
                                conditionBuilder: (context)=> state is! MovieLoginLoadingState,
                                widgetBuilder: (context)=> defaultMaterialButton(
                                    onPressed: (){
                                      if(formKey.currentState!.validate()){
                                        if(TOKEN==null)
                                          cubit.generateToken();
                                        MovieLoginCubit.get(context).createSessionWithLogIn(email:emailController.text, password: passwordController.text);
                                        MovieLoginCubit.get(context).loginByEmailAndPass(email: emailController.text, password: passwordController.text);

                                      }
                                    },
                                    text: 'login',
                                    radius: 15,
                                    gradientColorsList: [
                                      Colors.blue,
                                      Colors.blue.withOpacity(0.5)
                                    ],
                                    boxShadowColor: Colors.blue
                                ),
                                fallbackBuilder: (context)=>const CircularProgressIndicator()
                            ),

                            const SizedBox(height:   15,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "don't have an account ?",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey[800]
                                  ),
                                ),
                                TextButton(
                                    onPressed: (){
                                      navigateTo(context, RegisterScreen());
                                    },
                                    child: const Text('Register Now'))
                              ],
                            ),

                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Text(
                                  ' OR ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5,),

                            Container(
                              width: double.infinity,

                              child: SignInButton(
                                Buttons.Google,
                                elevation: 4, text: ('Continue With Google'),
                                onPressed: ()  async {
                                  bool connection = await checkConnectivity();
                                  if (!connection) {
                                    showSimpleNotification(

                                      const Text(
                                          "no internet connection"
                                      ),
                                      background: Colors.green,
                                    );
                                  }
                                }
                              ),
                            ),
                          ],
                        ),

                      ],

                    ),
                  ),
                ),
              ),
            ),
          );
          },
      ),
    );
  }

  void showStylishDialog(context){
      StylishDialog(
        context: context,
        alertType: StylishDialogType.INFO,
        titleText: 'Authentication',
        contentText: 'Approve permission to complete authentication',
        confirmButton: MaterialButton(
          color: Colors.green,
          onPressed: () {
            tokenApproved = true;
            launchURL('https://www.themoviedb.org/authenticate/$TOKEN');
            Navigator.of(context).pop();
          },
          child: (
              const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              )),
        ),
        cancelButton: MaterialButton(
          color: Colors.green,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: (
              const Text(
                'cancel',
                style: TextStyle(color: Colors.white),
              )),
        ),
      ).show();

  }
}
//log in now to reserve tickets and enjoy watching the competitive matches