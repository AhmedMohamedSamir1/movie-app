import 'package:movie_app/models/user_model.dart';

abstract class MovieLoginStates {}


class MovieLoginInitialState extends MovieLoginStates {}

class MovieLoginLoadingState extends MovieLoginStates {}

class MovieLoginSuccessState extends MovieLoginStates {

  String? email;
  String? password;
  MovieLoginSuccessState({this.email, this.password});
}
class MovieLoginErrorState extends MovieLoginStates {}

class MovieLoginChangePassState extends MovieLoginStates {}

// generate token
class MovieLoadingGenerateTokenState extends MovieLoginStates {}
class MovieSuccessGenerateTokenState extends MovieLoginStates {}
class MovieErrorGenerateTokenState extends MovieLoginStates {}

// create session ID
class MovieLoginLoadingCreateSessionState extends MovieLoginStates {}
class MovieLoginSuccessCreateSessionState extends MovieLoginStates {}
class MovieLoginErrorCreateSessionState extends MovieLoginStates {}