import 'dart:convert';
import 'dart:io';

import 'package:all_flutter_project/main.dart';
import 'package:all_flutter_project/screens/LoginScreen.dart';
import 'package:all_flutter_project/utils/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

//ay get method request ta bar bar reuse kora hobe tai create koreci

class GetMethodRequester {



  //get method
  Future getRequest(String url) async {
    //try ar catch use koreci jodi api a kono error dekhai tahole handle korar jonno
    //jodi soti vabe kaj kore tahole try er vitor er code kaj korbe na hole catch er vitor kaj korbe
    try {
      http.Response response = await http.get(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          'token': UserData.token ?? "",

        },
      );

      var ResultBody=json.decode(response.body);


      if (response.statusCode == 200) {
        Logger().i(ResultBody['data']);

        Logger().i(jsonDecode(response.body));
        return jsonDecode(response.body);


      }
      /*
          statuscode jokhon user password change kore or24 hours por login korbe tokhon
          auto logout hoye jabe and login screen a niye asbe
           And
           jodi user login kore rekhe abar kichu khon por abar login korar try kore tahole main page a chole asbe auto
       */

      else if (response.statusCode == 401) {
        final sharepref = await SharedPreferences.getInstance();
        sharepref.clear();

        Navigator.pushAndRemoveUntil(
            MyApp.navigatorKey.currentState!.context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      } else {
        Logger().e("Requiest Failed");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

//post method
  Future PostRequest(String url, Map<String, String> body) async {
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            'token': UserData.token ?? "",
          },
          //jsonEncode mane map theke json a convert kora hoice
          body: jsonEncode(body));

      //logger().i use koreci jno akhane success howar por status conde ar body value dekhabe i mane sucess color diye
      Logger().i(response.statusCode);
      Logger().i(jsonDecode(response.body));

      if (response.statusCode == 200) {
        /*
        jsonDecode mane json theke map a convert kora hoice and
        seta return kora hoice je function call korece okhane
        */
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        final sharepref = await SharedPreferences.getInstance();
        sharepref.clear();

        Navigator.pushAndRemoveUntil(
            MyApp.navigatorKey.currentState!.context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      } else {
        //logger().e use koreci jno akhane error  request faild dekhabe e mane error color diye android studio er run a dekhabe

        Logger().e("Request Faild");
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
