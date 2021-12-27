import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/models/user_model.dart';

abstract class MovieRegisterStates {}


class MovieRegisterInitialState extends MovieRegisterStates {}

class MovieRegisterLoadingState extends MovieRegisterStates {}
class MovieRegisterSuccessState extends MovieRegisterStates {
  String? email;
  String? password;
  MovieRegisterSuccessState({this.email, this.password});
}
class MovieRegisterErrorState extends MovieRegisterStates {}

class MovieRegisterChangePassState extends MovieRegisterStates {}

// generate token
class MovieLoadingGenerateTokenState extends MovieRegisterStates {}
class MovieSuccessGenerateTokenState extends MovieRegisterStates {}
class MovieErrorGenerateTokenState extends MovieRegisterStates {}