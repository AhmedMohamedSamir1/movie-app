

import 'package:bloc/bloc.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/favourites_screen/favourites_screen.dart';
import 'package:movie_app/home_screen/home_screen.dart';
import 'package:movie_app/models/list_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/movie_layout/states.dart';
import 'package:movie_app/shared/components/basics.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/dio_helper.dart';
import 'package:movie_app/shared/network/firebase_class.dart';
import 'package:movie_app/user_list/user_lists_screen.dart';

class MovieLayoutCubit extends Cubit<MovieLayoutStates>
{
  MovieLayoutCubit() : super(MovieLayoutInitialState());

  static MovieLayoutCubit get(context)
  {
    return BlocProvider.of(context);
  }

  //------start change  bottom nav bar --------
  int bottomNavBarIndex = 0;

  List<Widget> btmNavBarScreen = [
    HomeScreen(),
    TopRatedScreen(),
    UserListsScreen(),
  ];

  List<String> titles = [
    'popular',
    'top rated',
    'your lists',
  ];
  List<BottomNavyBarItem> bottomNavBarItems = [

    BottomNavyBarItem(
      icon: const Icon(Icons.movie_creation_outlined),
      title: const Text('popular'),
      activeColor: Colors.white,
      inactiveColor: Colors.white
    ),
    BottomNavyBarItem(
        icon:  const Icon(Icons.star_rate_outlined,),
        title: const Text('top rated'),
        activeColor: Colors.white,
        inactiveColor: Colors.white,
    ),
    BottomNavyBarItem(
        icon:  const Icon(Icons.list,),
        title: const Text('lists'),
        activeColor: Colors.white,
        inactiveColor: Colors.white,
    ),

  ];

  void changeBottomNavBar(int index)
  {
      bottomNavBarIndex = index;
      emit(MovieLayoutChangeBottomNavBarState());
  }
//------end change bottom nav bar  --------

  //----------start get popular films at page 1 --------------------
  List<MovieModel> popularMovies = [];
  int totalPages = 500;
  getPopularMovies(int page){
    emit(MovieLoadingGetPopularMoviesState());

    popularMovies = [];
    DioHelper.getData(

        url: 'movie/popular',
        query: {
          'api_key':apiKey,
          'page': page
        }
    ).then((value){

      //print(value.data);

      value.data['results'].forEach((element){
        MovieModel movieModel = MovieModel.fromJson(element);
        popularMovies.add(movieModel);
      });
      emit(MovieSuccessGetPopularMoviesState());

    }).catchError((onError){

      print('Error--> '+onError.toString());
      emit(MovieErrorGetPopularMoviesState());

    });
  }
  //----------end get popular films at page 1 -----------------

  //----------start get top rated films at page 1 --------------------
  List<MovieModel> topRatedMovies = [];
  getTopRatedMovies(int page){
    emit(MovieLoadingGetTopRatedMoviesState());

    topRatedMovies = [];
    DioHelper.getData(

        url: 'movie/top_rated',
        query: {
          'api_key':apiKey,
          'page': page
        }
    ).then((value){

      //print(value.data);

      value.data['results'].forEach((element){
        MovieModel movieModel = MovieModel.fromJson(element);
        topRatedMovies.add(movieModel);
      });
      emit(MovieSuccessGetTopRatedMoviesState());

    }).catchError((onError){

      print('Error--> '+onError.toString());
      emit(MovieErrorGetTopRatedMoviesState());

    });
  }
  //----------end get top rated films at page 1 -----------------

  //---- start get movies genres ----
  Map<int, String> moviesGenres = {};
  void getMoviesGenres()
  {
    emit(MovieLoadingGetGenresMoviesState());
    moviesGenres = {};
    DioHelper.getData(

        url: 'genre/movie/list',
        query: {
          'api_key':apiKey,
        }
    ).then((value){

      //print(value.data);
      value.data['genres'].forEach((element){
        moviesGenres.addAll({element['id']:element['name']});
      });
      emit(MovieSuccessGetGenresMoviesState());
      print(moviesGenres);

    }).catchError((onError){

      print('Error--> '+onError.toString());
      emit(MovieErrorGetGenresMoviesState());

    });
  }
  //---- end   get movies genres ----

  // ----start search movie-----
  List<MovieModel> searchMovieList = [];
  void getSearchMovie(String movieName){

    emit(MovieLoadingGetSearchMoviesState());
    searchMovieList = [];
    DioHelper.getData(
      url: 'search/movie',
      query: {
        'api_key':apiKey,
        'query': movieName,
      }
    ).then((value) {
    //  print(value.data);
      value.data['results'].forEach((element){
        MovieModel movieModel = MovieModel.fromJson(element);
        searchMovieList.add(movieModel);
      });
      emit(MovieSuccessGetSearchMoviesState());

    }).catchError((onError){
      emit(MovieErrorGetSearchMoviesState());
      print('Error--> '+onError.toString());
    });
  }
  // ----end search movie-----

  //----- start createSessionWithLogIn-----
  void createSessionWithLogIn({
    required String username,
    required String password,
  }){
    emit(MovieLoadingCreateSessionState());
    DioHelper.postData(
      url: 'authentication/session/new',
      data: null,
      query: {
        'api_key':apiKey,
        'request_token':TOKEN,
        "username": username,
        "password": password,
      },

    ).then((value){

      // print(value.extra);
      print('Session ID --------> ');
      print(value.data);
      // TOKEN = value.data['request_token'];
      // print('token = '+ TOKEN.toString());

      emit(MovieSuccessCreateSessionState());

    }).catchError((onError){

      print('Error--> '+onError.toString());
      emit(MovieErrorCreateSessionState());
      launchURL('https://www.themoviedb.org/authenticate/$TOKEN');
    });
  }
  //------ end createSessionWithLogIn-----

  //----- start rate movie -----
  void rateMovie({
    required int movieId,
    required double rate,
  }){
    emit(MovieLoadingRateMovieState());
    DioHelper.postData(
      url: 'movie/$movieId/rating',
      data: null,
      query: {
        "movie_id": movieId,
        'api_key':apiKey,
        'session_id':SESSION_ID,
        'value': rate
      },

    ).then((value){

      print(value.data);
      if(value.data['status_code']==1){
        toastMessage(textMessage: 'your rating is done successfully', toastState: ToastStates.SUCCESS);
      }

      if(value.data['status_code']==12){
        toastMessage(textMessage: 'your rating is updated successfully', toastState: ToastStates.SUCCESS);
      }

      emit(MovieSuccessRateMovieState());

    }).catchError((onError){

      print('Error--> '+onError.toString());
      emit(MovieErrorRateMovieState());
    });
  }
  //------ end rate movie -----


//----- start createList--------
  String? listId;
  void createNewList({
    required String listTitle,
    String? listDescription,
    required int movieId,

  }){
    emit(MovieLoadingCreateListState());
    DioHelper.postData(
      url: 'list',
      data: null,
      query: {
        'Content-Type':'application/json;charset=utf-8',
        'api_key':apiKey,
        'session_id':SESSION_ID,
        'name': listTitle,
        'description': listDescription??''
      }
    ).then((value){
      if(value.data['success'] && value.data['status_code']==1){
        listId = value.data['list_id'].toString();

        FirebaseFirestore.instance
            .collection('list')
            .doc(TOKEN)
            .collection('lists')
            .doc(listId)
            .set({'listId':listId, 'listName':listTitle})
            .catchError((onError){
              emit(MovieErrorCreateListState());
        });
        addMovieToList(listId: listId!, mediaId: movieId);
      }
      print("ListId -------->" + listId.toString());
       emit(MovieSuccessCreateListState());
    }).catchError((onError){
      print('Error--> '+onError.toString());
       emit(MovieErrorCreateListState());
    });
  }
  //----- end createList--------

  //----start add movie to list -------
  void addMovieToList({
    required String listId,
    required int mediaId,

  }){
    emit(MovieLoadingAddMovieToListState());
    DioHelper.postData(
        url: 'list/$listId/add_item',
        query: {
          'Content-Type':'application/json;charset=utf-8',
          'api_key':apiKey,
          'session_id':SESSION_ID,
          'media_id': mediaId,
        },
        data: null
    ).then((value) {
      print('-----------------');
      print(value.data);
      if(value.data['status_code']==12){
        simpleNotificationMessage(msgText: 'Movie added successfully',);
      }
      emit(MovieSuccessAddMovieToListState());
    }).catchError((onError){
      print('error ---------> '+onError.toString());
      emit(MovieErrorAddMovieToListState());
    });
  }
  //----end add movie to list   -------

  //----- start check if movie exist in list ------
  Future<bool> isMovieExist({
    required String listId,
    required int movieId,
  }) async {
    emit(MovieLoadingCheckIfMovieExistInListState());
    try{
      var res = await DioHelper.getData(
          url: 'list/$listId/item_status',
          query: {
            'list_id':listId,
            'api_key':apiKey,
            'movie_id':movieId,
          }
      );
      emit(MovieSuccessCheckIfMovieExistInListState());
      if(res.data['item_present'] == false){
        return true;
      }
      return false;

    }catch(onError){
      print(onError.toString());
      emit(MovieErrorCheckIfMovieExistInListState());
      return false;
    }
  }
  //---- start get list movies --------
  List<MovieModel> listMovies = [];
  void getListMovies({
    required String listId,
  }){
    emit(MovieLoadingGetListMoviesState());
    listMovies = [];
    DioHelper.getData(
      url: 'list/$listId',
      query: {
        'list_id':listId,
        'api_key':apiKey,
      }
    ).then((value){
        value.data['items'].forEach((element){
          listMovies.add(MovieModel.fromJson(element));
        });
        emit(MovieSuccessGetListMoviesState());

    }).catchError((onError){
      print(onError.toString());
      emit(MovieErrorGetListMoviesState());

    });
  }

  //---- end get list movies ----------


  //---- start get user list from fire store --------
  List<ListModel> userLists = [];
  void getUserLists()
  {
    emit(MovieLoadingGetUserListsState());
    userLists = [];
    FirebaseFirestore.instance
        .collection('list')
        .doc(TOKEN)
        .collection('lists')
        .snapshots().listen((event) {
          userLists = [];
          for (var element in event.docs) {
            userLists.add(ListModel.fromJson(element.data()));
          }
      emit(MovieSuccessGetUserListsState());
    });
  }
  //---- end get user list from fire store ----------

  //---- start add to favourite --------

  void addMovieToFav({
    required String movieGenres,
    required MovieModel movieModel,

  })
  {
    emit(MovieLoadingAddMovieToFavoritesState());

    FirebaseFirestore.instance
        .collection('favourites')
        .doc(TOKEN)
        .collection('fav_movies')
        .doc(movieModel.movieId.toString())
        .set(movieModel.toMap(movieGenres)).then((value){
          simpleNotificationMessage(msgText: 'added to favourites');
      emit(MovieSuccessAddMovieToFavoritesState());

    }).catchError((onError){
      emit(MovieErrorAddMovieToFavoritesState());
      print('----> '+ onError.toString());
    });
    }
  //---- end add to favourite --------

  //--------------------------
  List<MovieModel> favMovies = [];
  void getMoviesFromFav()
  {
    emit(MovieLoadingGetFavMoviesState());
    favMovies = [];
    FirebaseFirestore.instance
        .collection('favourites')
        .doc(TOKEN)
        .collection('fav_movies')
        .snapshots()
        .listen((event) {

      favMovies = [];
      event.docs.forEach((element) {
        MovieModel movieModel = MovieModel.fromJson(element.data());
        favMovies.add(movieModel);
      });

      for(int i=0;i<favMovies.length;i++){
        print('Movie name ------------> ' + favMovies[i].movieTitle!);
      }

      emit(MovieSuccessGetFavMoviesState());
    });
  }
  //--------------------------

  //------- start clear list -------------
  void clearList({
    required String listId,
  }){
    emit(MovieLoadingClearListState());
    DioHelper.postData(
        data: null,
        url: 'list/$listId/clear',
        query: {
          'list_id': listId,
          'api_key': apiKey,
          'session_id': SESSION_ID,
          'confirm': true,
        }
    ).then((value){
      if(value.data['status_code']==12) {
        simpleNotificationMessage(msgText: 'List Cleared');
        emit(MovieSuccessClearListState());
      }
    }).catchError((onError){
      print(onError.toString());
      emit(MovieErrorClearListState());

    });
  }
  //--------end clear list ---------------

  //--------start remove list -------------

  void removeListFromFireStore(String listId){
    emit(MovieLoadingRemoveListState());
    FirebaseFirestore.instance.collection('list').doc(TOKEN).collection('lists').doc(listId).delete()
        .then((value) {
      simpleNotificationMessage(msgText: 'list removed');
      emit(MovieSuccessRemoveListState());
    }).catchError((onError){
      print('error -----------> '+ onError.toString());
      emit(MovieErrorRemoveListState());
    });
  }

  // void removeList({
  //   required String listId
  // }){
  //   emit(MovieLoadingRemoveListState());
  //   print(listId);
  //   DioHelper.deleteData(
  //     url: 'list/$listId',
  //     query: {
  //       'list_id': listId,
  //       'api_key': apiKey,
  //       'session_id': SESSION_ID,
  //     }
  //   ).then((value) {
  //     if(value.data['status_code']==12){
  //       removeListFromFireStore(listId);
  //     }
  //   }).catchError((onError){
  //    print('error -----------> '+ onError.toString());
  //   });
  // }
//--------end  remove list -----------------------

  //---- start remove Movie from list-----
  void removeMovieFromList({
    required String lstId,
    required int movieId,
  }){
    emit(MovieLoadingRemoveMovieFromListState());
    DioHelper.postData(
      url: 'list/$lstId/remove_item',
      data: null,
      query: {
        'list_id':listId,
        'Content-Type':'application/json;charset=utf-8',
        'api_key':apiKey,
        'session_id':SESSION_ID,
        'media_id':movieId,
      }
    ).then((value) {
      if(value.data['status_code']==13){
        simpleNotificationMessage(msgText: 'movie removed');
      }
      emit(MovieSuccessRemoveMovieFromListState());
    }).catchError((onError){
      emit(MovieErrorRemoveMovieFromListState());
    });
}
  //---- end remove Movie from list-----
void reload(){emit(MovieReloadState());}

}


