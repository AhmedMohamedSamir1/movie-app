// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{

  static late SharedPreferences sharedPreferences;

  //------------start sharedPreferences initialization-------------------
  static Future init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  //------------end sharedPreferences initialization---------------------

//------------start save data------------------------------
  static Future saveData({
    required String key,
    required dynamic value,

  })async
  {
    if(value is String) return await sharedPreferences.setString(key, value);
    else if(value is int) return await sharedPreferences.setInt(key, value);
    else if(value is bool) return await sharedPreferences.setBool(key, value);
    else return await sharedPreferences.setDouble(key, value);

  }
//----------------end save data---------------------------------

//----------------start get saved data--------------------------

  static dynamic getSavedData({required String key})
  {
    return sharedPreferences.get(key);
  }

//----------------end get saved data------------------------------


//----------------start remove data---------------------------------

  static Future<bool> removeData({
    required String key
  })async
  {
    return await sharedPreferences.remove(key);
  }
//----------------end remove data--------------------------------
}