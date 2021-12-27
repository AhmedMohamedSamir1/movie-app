
import 'package:dio/dio.dart';

// https://api.themoviedb.org/3/authentication/token/new?api_key=dd8adc5ede0577f09c6d6dfb1c4dded0

class DioHelper
{
  static late Dio dio;

  static void init()
  {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.themoviedb.org/3/',
          receiveDataWhenStatusError: true, // get data even if error occurred when data is retrieved

          // the headers that appended to api and this header will be overrided if header add in function
          //   headers: {
          //   'Content-Type':'application/json',
          // }

        )
    );
  }


  static Future<Response> getData({
    required String url,                // method url
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token

  })async
  {
    // headers that appended when use this method and this header will override the above header if exists

    // dio.options.headers = {
    //   'Content-Type':'application/json',
    //   'lang':lang,
    //   'Authorization':token??''
    // };

    //'charset'='utf-8'

    return await dio.get(url, queryParameters: query);
  }

  //-------------------------------------
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token

  })async
  {
    // headers that appended when use this method will override the above header if exists

    //  dio.options.headers = {
    //   'Content-Type':'application/json',
    //   'lang':lang,
    //   'Authorization':token??'',
    //
    // };
    return await dio.post(
        url,
        queryParameters: query,
        data: data
    );
  }
  //--------------------------

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token

  })async
  {
    // headers that appended when use this method will override the above header if exists

    dio.options.headers = {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??'',

    };
    return await dio.put(

        url,
        queryParameters: query,
        data: data
    );
  }

  //---------------------------
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token

  })async
  {
    // headers that appended when use this method will override the above header if exists
    // dio.options.headers = {
    //   'Content-Type':'application/json',
    //   'lang':lang,
    //   'Authorization':token??'',
    //
    // };
    return await dio.delete(
      url,
      queryParameters: query,
      data: data,

    );
  }
  //---------------------------
}