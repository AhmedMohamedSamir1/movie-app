import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/movie_details/movie_details_screen.dart';
import 'package:movie_app/movie_layout/cubit.dart';
import 'package:movie_app/movie_layout/states.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              'Search',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      defaultTextFormField(
                          fieldController: searchController,
                          inputType: TextInputType.text,
                          maxLines: 1,
                          validator: (String? value) {},
                          fieldColor: Colors.white,
                          labelText: 'Enter Movies',
                          // borderRadius: 14,
                          onChange: (String val) {
                            if (val != '') {
                              cubit.getSearchMovie(val);
                            }
                          },
                          prefixIcon: Icons.search),
                      if(state is MovieLoadingGetSearchMoviesState)
                        LinearProgressIndicator(
                        minHeight: 5,
                        color: Colors.red,
                        backgroundColor: Colors.red.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          buildItem(cubit.searchMovieList[index], context),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: cubit.searchMovieList.length),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildItem(MovieModel movieData, context) {
    String movieGenres = getMovieGenre(movieData.genresId!, context);
    return InkWell(
      onTap: () {
        navigateTo(context, MovieDetailsScreen(movieData: movieData, movieGenres: movieGenres));
      },
      child: Column(
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
                      movieData.moviePoster != null?
                      'https://image.tmdb.org/t/p/w500${movieData.moviePoster}':
                      'https://cdn.staticcrate.com/stock-hd/effects/footagecrate-red-error-icon-prev-full.png',

                    )
                ),
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
                    Text(
                      '${movieData.movieReleaseDate}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, color: Colors.white),
                    )
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
      ),
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
}
