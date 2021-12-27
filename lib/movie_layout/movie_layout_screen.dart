import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie_app/models/user_model.dart';
import 'package:movie_app/movie_layout/cubit.dart';
import 'package:movie_app/movie_layout/states.dart';
import 'package:movie_app/search_screen/search_screen.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/styles/colors.dart';

class MovieLayoutScreen extends StatelessWidget {
  String? email;
  String? password;

  MovieLayoutScreen({Key? key,  this.email, this.password }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if(email!=null) {
    //   MovieLayoutCubit.get(context).createSessionWithLogIn(username: email!, password: password!);
    // }
    return BlocConsumer<MovieLayoutCubit, MovieLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MovieLayoutCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.bottomNavBarIndex],
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, fontSize: 22),
              ),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, SearchScreen());
                }, icon: const Icon(Icons.search, color: Colors.white,size: 30,))
              ],
              centerTitle: true,
              backgroundColor: defaultColor,
            ),
            bottomNavigationBar: BottomNavyBar(

              backgroundColor: defaultColor,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              iconSize: 30,
              selectedIndex: cubit.bottomNavBarIndex,
              onItemSelected: (int index) {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomNavBarItems,

            ),
          body: cubit.btmNavBarScreen[cubit.bottomNavBarIndex]
        );
      },
    );
  }
}
