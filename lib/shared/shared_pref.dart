
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences? sharedPreferences;
  static Future initialSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

 static Future<bool> saveDate(
    {
     @required String? key,
     @required String? value,
    }
  ) async {
    // final sharedPreferences = await SharedPreferences.getInstance();
   return await sharedPreferences!.setString(key!, value!);
  }

  
  

   static String? getDataSt(
    {
     @required String? key,
    }
  ){
    // final sharedPreferences = await SharedPreferences.getInstance();
   return sharedPreferences!.getString(key!);
  }



  
}
