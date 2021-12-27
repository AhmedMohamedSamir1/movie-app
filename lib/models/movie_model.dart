class MovieModel{

  String? moviePoster;
  bool? adult;
  String? movieOverview;
  String? movieReleaseDate;
  List<int>? genresId=[];
  int? movieId;
  String? movieOriginalTitle;
  String? movieTitle;
  String? movieOriginalLang;
  String? movieBackDropPath;
  double? moviePopularity;
  int? voteCount;
  bool? video;
  double? voteAverage;

  MovieModel.fromJson(Map<String, dynamic>json){
    moviePoster =  json['poster_path'];
    adult =  json['adult'];
    movieOverview =  json['overview'];
    movieReleaseDate =  json['release_date'];
    if(json['genre_ids']!=null){
      json['genre_ids'].forEach((element){
        genresId!.add(element);
      });
    }


    movieId =  json['id'];
    movieOriginalTitle =  json['original_title'];
    movieOriginalLang =  json['original_language'];
    movieTitle =  json['title'];
    movieBackDropPath =  json['backdrop_path'];
    moviePopularity =  json['popularity'].toDouble();
    voteCount =  json['vote_count'];
    video =  json['video'];
    voteAverage =  json['vote_average'].toDouble();
  }

  Map<String, dynamic> toMap(genres){
    return {
      'poster_path':moviePoster,
      'adult':adult,
      'overview':movieOverview,
      'release_date':movieReleaseDate,
      'genre_ids':genres,
      'id':movieId,
      'original_title':movieOriginalTitle,
      'original_language':movieOriginalLang,
      'title':movieTitle,
      'backdrop_path':movieBackDropPath,
      'popularity':moviePopularity,
      'vote_count':voteCount,
      'video':video,
      'vote_average':voteAverage,
    };
  }


}