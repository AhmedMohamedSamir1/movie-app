import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:movie_app/models/list_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/movie_details/movie_details_screen.dart';
import 'package:movie_app/movie_layout/cubit.dart';
import 'package:movie_app/movie_layout/states.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/styles/colors.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class ListMoviesScreen extends StatelessWidget {
  ListModel listModel;

  ListMoviesScreen({Key? key, required this.listModel}) : super(key: key);
  int start = 3;
  @override
  Widget build(BuildContext context) {
    start = 3;
    print('start ----> '+start.toString());
    startTimer(context);
    return BlocConsumer<MovieLayoutCubit, MovieLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MovieLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: defaultColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              listModel.listName,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            centerTitle: true,
          ),
          body: Conditional.single(
              context: context,
              conditionBuilder: (context) => cubit.listMovies.length != 0,
              widgetBuilder: (context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        // shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            buildItem(cubit.listMovies[index], context, index),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: cubit.listMovies.length),
                  ),
              fallbackBuilder: (context) {
                if(start==0 && cubit.listMovies.length==0) {
                  return Center(
                  child: Text(
                    'No movies found',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 18, color: Colors.white),
                  ),
                );
                }
                else{
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
              }
              ),
        );
      },
    );
  }

  Widget buildItem(MovieModel movieData, context, index) {
    String movieGenres = getMovieGenre(movieData.genresId!, context);
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: MediaQuery.of(context).size.height * 0.32,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    movieData.moviePoster != null
                        ? 'https://image.tmdb.org/t/p/w500${movieData.moviePoster}'
                        : 'https://cdn.staticcrate.com/stock-hd/effects/footagecrate-red-error-icon-prev-full.png',
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${movieData.movieTitle}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 22, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    movieGenres,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rate,
                        color: Colors.yellow,
                        size: 22,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${movieData.voteAverage}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18, color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  defaultOutLinedButton(
                    btnText: 'remove from list',
                    btnTxtColor: Colors.white,
                    borderColor: Colors.white,
                    txtStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18, color: Colors.white),
                    onClick: (){
                      removeMovieFromList(context,  movieData,  index);
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        myDivider(height: 3),
      ],
    );
  }

  String getMovieGenre(List<int> list, context) {
    if (list.length > 0) {
      String genre =
          MovieLayoutCubit.get(context).moviesGenres[list[0]].toString() + '/';
      for (int i = 1; i < list.length - 1; i++) {
        genre +=
            MovieLayoutCubit.get(context).moviesGenres[list[i]].toString() +
                '/';
      }
      genre += MovieLayoutCubit.get(context)
          .moviesGenres[list[list.length - 1]]
          .toString();
      return genre;
    }
    return 'not found';
  }

  void removeMovieFromList(context, MovieModel movieModel,  int index) {
    StylishDialog(
      context: context,
      alertType: StylishDialogType.WARNING,
      titleText: 'remove movie',
      contentText: 'Are you sure that you want to remove movie from ${listModel.listName} list',
      confirmButton: MaterialButton(
        color: Colors.green,
        onPressed: () {
          MovieLayoutCubit.get(context).listMovies.removeAt(index);
          MovieLayoutCubit.get(context).removeMovieFromList(
              lstId: listModel.listId,
              movieId: movieModel.movieId!
          );
          Navigator.pop(context);
        },
        child: (const Text(
          'OK',
          style: TextStyle(color: Colors.white),
        )),
      ),
      cancelButton: MaterialButton(
        color: Colors.green,
        onPressed: () {
          Navigator.pop(context);
        },
        child: (const Text(
          'cancel',
          style: TextStyle(color: Colors.white),
        )),
      ),
    ).show();
  }

  void startTimer(context) {
    const Duration oneSec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
          if (start == 0) {
            timer.cancel();
            print(start);
        } else {
            start--;
            MovieLayoutCubit.get(context).reload();
            print(start);
        }
      },
    );
  }
}
