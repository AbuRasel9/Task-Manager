import 'package:all_flutter_project/Task%20Manager%20Project/style/Style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../RestApi/RestApi.dart';
import '../screens/MainBottomNavBarScreen.dart';
import '../utils/UserData.dart';
//setState na use kore GetxController use koreci ata screen load newar jonno
class LoginController extends GetxController{
  bool LoginInProgress=false;

  //Login
  Future<bool> LoginWithEmailPassword  (String Email, Password) async {
    //screen auto update hoye jabe ja ja change korci
    update();
    LoginInProgress=true;
      final result = await GetMethodRequester()
          .PostRequest("https://task.teamrabbil.com/api/v1/login", {
        "email": Email,
        "password": Password,
      });
      LoginInProgress=false;
      update();

      if (result["status"] == "success") {
        /*
                                Share preference(mane Jodi kono apps a login kori pore app ta restart dei
                                tahole jeno abar login screen a na ese login korar por je page a asto oi page a ase)

                                */

        /*
                            niche SharePref use kore ki ki value loging korar por pawa jai ta newar jonno
                            (SharedPreferences.getInstance()) use koreci jeno data gula niye pore app ta restart
                            korle login page na giye Main page a jai
                             */

        final sharePref = await SharedPreferences.getInstance();

        /*User data te token,firstName,lastName,email
                                agula value sob userData class Mane UserData file a patai disi
                                jeno appBar a ay value gual use korte pari
                                 */

        UserData.token = result['token'];
        UserData.firstName = result['data']['firstName'];
        UserData.lastName = result['data']['lastName'];
        UserData.email = result['data']['email'];
        UserData.phone = result['data']['mobile'];

        sharePref.setString('email', result['data']['email']);

        sharePref.setString('firstName', result['data']['firstName']);

        sharePref.setString('lastName', result['data']['lastName']);
        sharePref.setString('phone', result['data']['mobile']);

        sharePref.setString('token', result['token']);
        //Get.offAll() ata pushAndRemoveUntil er motoi kaj kore

        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             MainBottomNavBarScreen()),
        //     (route) => false);
        return true;
      } else {
        return false;
      }
    }
  }

