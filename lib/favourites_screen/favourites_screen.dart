import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/movie_details/movie_details_screen.dart';
import 'package:movie_app/movie_layout/cubit.dart';
import 'package:movie_app/movie_layout/states.dart';
import 'package:movie_app/shared/components/components.dart';

class TopRatedScreen extends StatelessWidget {
  TopRatedScreen({Key? key}) : super(key: key);


  int selectedPage =1;
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieLayoutCubit, MovieLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MovieLayoutCubit.get(context);

        if(firstTime){
          return Conditional.single(
              context: context,
              conditionBuilder: (context)=> cubit.topRatedMovies.length!=0,
              widgetBuilder:(context)=> Container(
                color: HexColor('21232E'),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.10,
                          child: ListView.separated(
                            itemBuilder: (context, index)=> InkWell(
                              onTap: (){
                                selectedPage = index+1;
                                cubit.getTopRatedMovies(selectedPage);
                                firstTime = false;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: index+1==selectedPage? HexColor('5D75CB'):HexColor('21232E'),
                                  border: Border.all(color: Colors.white),
                                ),
                                width: MediaQuery.of(context).size.width*0.17,

                                child: Center(
                                  child: Text(
                                    '${index+1}',
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 22,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            separatorBuilder: (BuildContext context, int index) => SizedBox(width: 15,),
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.totalPages,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        myDivider(dividerColor: Colors.white),
                        const SizedBox(height: 10,),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2, // grid row consist of 2 cells
                          mainAxisSpacing: 1,
                          // space between items of column
                          crossAxisSpacing: 5,
                          // space between items of row
                          children: List.generate(
                              cubit.topRatedMovies.length,
                                  (index) =>
                                  buildGridMovie(cubit.topRatedMovies[index], context)),
                          childAspectRatio: 1 / 2.1, // width / height
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              fallbackBuilder: (context)=> Container(
                color: HexColor('21232E'),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.red,),
                ),
              )
          );
        }
        else{
          return Container(
            color: HexColor('21232E'),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.10,
                      child: ListView.separated(
                        itemBuilder: (context, index)=> InkWell(
                          onTap: (){
                            selectedPage = index+1;
                            cubit.getTopRatedMovies(selectedPage);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: index+1==selectedPage? HexColor('5D75CB'):HexColor('21232E'),
                              border: Border.all(color: Colors.white),
                            ),
                            width: MediaQuery.of(context).size.width*0.17,

                            child: Center(
                              child: Text(
                                '${index+1}',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 22,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                        separatorBuilder: (BuildContext context, int index) => SizedBox(width: 15,),
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.totalPages,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    myDivider(dividerColor: Colors.white),
                    const SizedBox(height: 10,),

                    Conditional.single(
                        context: context,
                        conditionBuilder: (context)=> cubit.topRatedMovies.length!=0,
                        widgetBuilder: (context)=>GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2, // grid row consist of 2 cells
                          mainAxisSpacing: 1,
                          // space between items of column
                          crossAxisSpacing: 5,
                          // space between items of row
                          children: List.generate(
                              cubit.topRatedMovies.length,
                                  (index) =>
                                  buildGridMovie(cubit.topRatedMovies[index], context)),
                          childAspectRatio: 1 / 2.1, // width / height
                        ),
                        fallbackBuilder: (context)=> Container(
                          color: HexColor('21232E'),
                          child: const Center(
                            child: CircularProgressIndicator(color: Colors.red,),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          );
        }

      },
    );
  }

  Widget buildGridMovie(MovieModel movie, context) {
    var cubit = MovieLayoutCubit.get(context);
    String movieGenre = getMovieGenre(movie.genresId!, context);

    return InkWell(
      onTap: (){
        navigateTo(context, MovieDetailsScreen(movieData: movie, movieGenres: movieGenre));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: movie.moviePoster != null
                  ? Image.network(
                'https://image.tmdb.org/t/p/w500${movie.moviePoster!}',
              )
                  : Image.asset(
                'assets/images/errorLoading1.jpg',
              )),
          const SizedBox(
            height: 5,
          ),
          Text(
            movie.movieTitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 18,
                color: Colors.white
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movieGenre,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 15,
                color: Colors.grey
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(Icons.star_rate, color: Colors.yellow, size: 20,),
              const SizedBox(width: 8,),
              Text('${movie.voteAverage}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 15,
                    color: Colors.white
                ),)
            ],
          )
        ],
      ),
    );
  }

  String getMovieGenre(List<int>list, context){
    String genre = MovieLayoutCubit.get(context).moviesGenres[list[0]].toString()+'/';
    for(int i = 1 ; i< list.length-1; i++){
      genre += MovieLayoutCubit.get(context).moviesGenres[list[i]].toString()+'/';
    }
    genre += MovieLayoutCubit.get(context).moviesGenres[list[list.length-1]].toString();
    return genre;
  }
}
