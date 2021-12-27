// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/user_model.dart';
import 'package:movie_app/modules/register/states.dart';
import 'package:movie_app/shared/components/basics.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/dio_helper.dart';
import 'package:movie_app/shared/network/firebase_class.dart';


class MovieRegisterCubit extends Cubit<MovieRegisterStates>{

  MovieRegisterCubit() : super(MovieRegisterInitialState());

  static MovieRegisterCubit get(context)
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
    emit(MovieRegisterChangePassState());
  }
  //-------end password visibility---------

  //---start confirm password visibility----
  bool confirmPassVisibility = true;
  IconData confirmPassVisibilityIcon  = Icons.visibility_off_outlined;
  void changeConfirmPassVisibility()
  {
    confirmPassVisibility = !confirmPassVisibility;
    confirmPassVisibilityIcon = confirmPassVisibility?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(MovieRegisterChangePassState());

  }
  //---end confirm password visibility-------

  //----- start registration by email and password-----

  void registerByEmailAndPass({
    required String name,
    required String email,
    required String password,
    required String phone,

  })
  {
   emit(MovieRegisterLoadingState());
    FireBaseClass.registerByEmailAndPass(email: email, password: password).then((value) {

      String uId = value.user!.uid;
      UserModel user = UserModel(uId: uId, name: name, email: email, phone: phone);

      FireBaseClass.addToFireSore(collectionName: 'user', docName: uId, model: user.toMap()).then((value) {
        emit(MovieRegisterSuccessState(email: email, password: password));
      }).catchError((onError){

        emit(MovieRegisterErrorState());
        print(onError.toString());
        toastMessage(textMessage: onError.toString(), toastState: ToastStates.ERROR);
      });
    }).catchError((onError){
      print(onError.toString());
      toastMessage(textMessage: onError.toString(), toastState: ToastStates.ERROR);
      emit(MovieRegisterErrorState());
    });
  }
  //----- end registration by email and password-----

}