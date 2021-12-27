abstract class MovieLayoutStates{}

class MovieLayoutInitialState extends MovieLayoutStates{}

class MovieLayoutChangeBottomNavBarState extends MovieLayoutStates{}




// get popular movies
class MovieLoadingGetPopularMoviesState extends MovieLayoutStates {}
class MovieSuccessGetPopularMoviesState extends MovieLayoutStates {}
class MovieErrorGetPopularMoviesState extends MovieLayoutStates {}

// get top rated movies
class MovieLoadingGetTopRatedMoviesState extends MovieLayoutStates {}
class MovieSuccessGetTopRatedMoviesState extends MovieLayoutStates {}
class MovieErrorGetTopRatedMoviesState extends MovieLayoutStates {}

// search movie
class MovieLoadingGetSearchMoviesState extends MovieLayoutStates {}
class MovieSuccessGetSearchMoviesState extends MovieLayoutStates {}
class MovieErrorGetSearchMoviesState extends MovieLayoutStates {}

// get movies genres
class MovieLoadingGetGenresMoviesState extends MovieLayoutStates {}
class MovieSuccessGetGenresMoviesState extends MovieLayoutStates {}
class MovieErrorGetGenresMoviesState extends MovieLayoutStates {}

// create session ID
class MovieLoadingCreateSessionState extends MovieLayoutStates {}
class MovieSuccessCreateSessionState extends MovieLayoutStates {}
class MovieErrorCreateSessionState extends MovieLayoutStates {}

// rate movie
class MovieLoadingRateMovieState extends MovieLayoutStates {}
class MovieSuccessRateMovieState extends MovieLayoutStates {}
class MovieErrorRateMovieState extends MovieLayoutStates {}


// create List
class MovieLoadingCreateListState extends MovieLayoutStates {}
class MovieSuccessCreateListState extends MovieLayoutStates {}
class MovieErrorCreateListState extends MovieLayoutStates {}

// add movie to List
class MovieLoadingAddMovieToListState extends MovieLayoutStates {}
class MovieSuccessAddMovieToListState extends MovieLayoutStates {}
class MovieErrorAddMovieToListState extends MovieLayoutStates {}


// get user Lists from fire store
class MovieLoadingGetUserListsState extends MovieLayoutStates {}
class MovieSuccessGetUserListsState extends MovieLayoutStates {}
class MovieErrorGetUserListsState extends MovieLayoutStates {}

// get List Movies
class MovieLoadingGetListMoviesState extends MovieLayoutStates {}
class MovieSuccessGetListMoviesState extends MovieLayoutStates {}
class MovieErrorGetListMoviesState extends MovieLayoutStates {}

// check if a movie has already been added to the list.
class MovieLoadingCheckIfMovieExistInListState extends MovieLayoutStates {}
class MovieSuccessCheckIfMovieExistInListState extends MovieLayoutStates {}
class MovieErrorCheckIfMovieExistInListState extends MovieLayoutStates {}


// add movie to favourites
class MovieLoadingAddMovieToFavoritesState extends MovieLayoutStates {}
class MovieSuccessAddMovieToFavoritesState extends MovieLayoutStates {}
class MovieErrorAddMovieToFavoritesState extends MovieLayoutStates {}

// get favourites movies
class MovieLoadingGetFavMoviesState extends MovieLayoutStates {}
class MovieSuccessGetFavMoviesState extends MovieLayoutStates {}
class MovieErrorGetFavMoviesState extends MovieLayoutStates {}

// remove List
class MovieLoadingRemoveListState extends MovieLayoutStates {}
class MovieSuccessRemoveListState extends MovieLayoutStates {}
class MovieErrorRemoveListState extends MovieLayoutStates {}

// clear List
class MovieLoadingClearListState extends MovieLayoutStates {}
class MovieSuccessClearListState extends MovieLayoutStates {}
class MovieErrorClearListState extends MovieLayoutStates {}

// remove movie from List
class MovieLoadingRemoveMovieFromListState extends MovieLayoutStates {}
class MovieSuccessRemoveMovieFromListState extends MovieLayoutStates {}
class MovieErrorRemoveMovieFromListState extends MovieLayoutStates {}

class MovieReloadState extends MovieLayoutStates {}