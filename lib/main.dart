import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_layout/cubit.dart';
import 'package:movie_app/shared/bloc_observer.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/cash_helper.dart';
import 'package:movie_app/shared/network/dio_helper.dart';
import 'package:movie_app/shared/styles/themes.dart';
import 'package:movie_app/test5.dart';
import 'package:overlay_support/overlay_support.dart';
import 'modules/login/cubit.dart';
import 'modules/login/login_screen.dart';
import 'movie_layout/movie_layout_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // it ensures that every thing in method done then run application
  await CashHelper.init();
  await Firebase.initializeApp();

  TOKEN = CashHelper.getSavedData(key: 'token');


  Widget startWidget = LoginScreen();
  if (TOKEN != null) {
    startWidget = MovieLayoutScreen();
    EMAIL = CashHelper.getSavedData(key: 'email');
    PASSWORD = CashHelper.getSavedData(key: 'password');
    SESSION_ID = CashHelper.getSavedData(key: 'sessionId');
    print(EMAIL);
    print(PASSWORD);
    print(SESSION_ID);
  }
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(startScreen: startWidget));
}

class MyApp extends StatelessWidget {
  Widget startScreen;

  MyApp({Key? key,  required this.startScreen}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return MovieLayoutCubit()
              ..getPopularMovies(1)
              ..getTopRatedMovies(1)
              ..getMoviesGenres()
              ..getUserLists();
          },
        ),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: startScreen
        ),
      ),
    );
  }
}
