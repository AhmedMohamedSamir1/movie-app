// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/approve_token/approve_token_screen.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/modules/login/states.dart';
import 'package:movie_app/movie_layout/states.dart';
import 'package:movie_app/shared/components/basics.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/cash_helper.dart';
import 'package:movie_app/shared/network/dio_helper.dart';
import 'package:movie_app/shared/network/firebase_class.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MovieLoginCubit extends Cubit<MovieLoginStates>{

  MovieLoginCubit() : super(MovieLoginInitialState());

  static MovieLoginCubit get(context)
  {
    return BlocProvider.of(context);
  }

  //-------start password visibility-------
  bool passVisibility = true;
  IconData passVisibilityIcon  = Icons.visibility_off_outlined;
  void changePassVisibility()
  {
    passVisibility = !passVisibility;
    passVisibilityIcon =  passVisibility?  Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(MovieLoginChangePassState());
  }
  //-------end password visibility---------


  //-----start login by email and password-----

  void loginByEmailAndPass({

    required String email,
    required String password,

  })
  {
   emit(MovieLoginLoadingState());

    FireBaseClass.userLogInByEmailAndPass(email: email, password: password).then((value) {

      emit(MovieLoginSuccessState(email: email, password: password));

    }).catchError((onError){
      print(onError.toString());
      toastMessage(textMessage: onError.toString(), toastState: ToastStates.ERROR);
      emit(MovieLoginErrorState());
    });
  }
  //-----end login by email and password-----


  //----- start login by google -----
  void signInByGoogle(context){
    // print('///////////////////////////////////////////////');
    // FireBaseClass.signInWithGoogle(context: context).then((value){
    //
    //    if(value!=null) {
    //      String uId = value.uid.toString();
    //      String userEmail = value.email.toString();
    //
    //      if (FirebaseAuth.instance.currentUser!.metadata.creationTime ==
    //          FirebaseAuth.instance.currentUser!.metadata.lastSignInTime)
    //      {
    //        String userName = value.displayName.toString();
    //        String phone = FirebaseAuth.instance.currentUser!.phoneNumber.toString();
    //        print('phone------------------> '+phone);
    //        UserModel model = UserModel(uId: uId, name: userName, email: userEmail, phone: phone);
    //        FireBaseClass.addToFireSore(collectionName: 'user', docName: uId, model: model.toMap());
    //      }
    //      emit(MovieLoginSuccessState(uId, userEmail,'google'));
    //    }
    // }).catchError((onError){
    //   toastMessage(textMessage: onError.toString(), toastState: ToastStates.ERROR);
    //   emit(MovieLoginErrorState());
    //   print(onError.toString());
    // });
  }
  //----- end login by google -----


  //-----start generate token -----------
  void generateToken(){
    emit(MovieLoadingGenerateTokenState());
    DioHelper.getData(
      url: 'authentication/token/new',
      query: {
        'api_key':apiKey,
      }
    ).then((value){

      print(value.data);
      TOKEN = value.data['request_token'];
      print('token = '+ TOKEN.toString());

      emit(MovieSuccessGenerateTokenState());

    }).catchError((onError){
      print('Error--> '+onError.toString());
      emit(MovieErrorGenerateTokenState());

    });
  }
  //-----end generate token -----------

  //----- start createSessionWithLogIn-----
  bool sessionCreated = false;
  void createSessionWithLogIn({
    required String email,
    required String password,
  }){
    emit(MovieLoginLoadingCreateSessionState());
    DioHelper.postData(
      url: 'authentication/session/new',
      data: null,
      query: {
        'api_key':apiKey,
        'request_token':TOKEN,
        "username": email,
        "password": password,
      },

    ).then((value){

      // print(value.extra);
      if(value.data['success']){
        SESSION_ID = value.data['session_id'];
        print('Session ID --------> '+SESSION_ID!);
        sessionCreated = true;
        CashHelper.saveData(key: 'sessionId', value: SESSION_ID.toString());
        toastMessage(textMessage: 'Session created successfully',toastState: ToastStates.SUCCESS);
      }
      emit(MovieLoginSuccessCreateSessionState());

    }).catchError((onError){

      print('Error--> '+onError.toString());
      emit(MovieLoginErrorCreateSessionState());
      sessionCreated = false;
    });
  }
//------ end createSessionWithLogIn-----

}
