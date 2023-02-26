import 'dart:convert';

import 'package:dio/dio.dart';

class DoiHelper {
 static Dio dio = Dio();
 static String serverToken = "AAAAuR8lcTc:APA91bH6LogWWQ_H0oUS5I9QXU28dg084a8Z_Dger9k1n2DWXvh3YGxeqGZd8xEH86Gw84HBOQDQTRh-BlXPJv8FbU3VJ4Wl0eAITk4DFIgmmHUbQp_KNfZ5JRKAtafQhJ5ZK2DofyBf";

 static Future<void> sendNorify({String? title, String? body}) async {
    dio.post(
      "https://fcm.googleapis.com/fcm/send",
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
      ),
      data: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': "title"},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            
            'status': 'done'
          },
          'to': "d2DK7AgxSUGlZdd5y6uKb8:APA91bEL_iXVy1NCPMwcSAkkA36cVwJAB7ffw8L07ypfB9dd0miE4cTp1VNoEnU-RlqG68g1eYeT9L_VTyDgSzDt0u8Q0ZhSt69DLCXAa9lew4ZYlaSE29RQOOk2nCDBnJUODo__w53F",
        },
      ),
    );

  }
}
