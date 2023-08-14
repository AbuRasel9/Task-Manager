import 'package:all_flutter_project/Task%20Manager%20Project/RestApi/RestApi.dart';
import 'package:all_flutter_project/Task%20Manager%20Project/utils/UserData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../StateManageMent/Login_Controller.dart';
import '../style/Style.dart';
import '../widgets/ReuseAbleElevatedButton.dart';
import 'ForgotPasswordScreen.dart';
import 'MainBottomNavBarScreen.dart';
import 'RegistrationScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController EmailValue = TextEditingController();
  TextEditingController PasswordValue = TextEditingController();

//Get.put use korci jeno LoginController er vitor ja ja change hoi life cycle change hoi
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    //form validation er jonno use koreci
    final _form = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Get Start With",
                        style: Heading1TextStyle(colorDarkBlue),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Learn With Rasel Ahmed",
                        style: Heading6Style(colorLightGray),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: EmailValue,
                        //value newar jonno use kora hoice
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Please Enter Email Address";
                          }

                          //null check korar jonno

                          return null;
                        },

                        decoration: FormFeildStyle("Email Address"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        //password der number dekha jabe na khali dot(...) dekha jabe value dile
                        controller: PasswordValue,
                        //value newar jonno use kora hoice
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Please Enter Password";
                          }

                          //null check korar jonno
                          return null;
                        },

                        decoration: FormFeildStyle("Password"),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      //akhane api login button a click korle circuller vabe ghurbe button




                      GetBuilder<LoginController>(
                          //LoginController er vitor kono change hole life cycle change hobe
                          init: LoginController(),
                          builder: (controller) {
                            if (loginController.LoginInProgress) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ReUseAbleElevatedButton(
                                onTap: () async {
                                  if (_form.currentState!.validate()) {
                                    final result=await loginController.LoginWithEmailPassword(EmailValue.text, PasswordValue.text);
                                    if(result==true){
                                      Get.offAll(MainBottomNavBarScreen());
                                      Get.snackbar("Login","Login SuccessFull");


                                    }else{
                                      Get.snackbar("Un successfull","Email or Password Wrong Try Again Letter");


                                    }

                                  }
                                },
                              );
                            }
                          }),

                      //Button

                      SizedBox(
                        height: 50,
                      ),

                      Center(
                        child: TextButton(
                            onPressed: () {
                              Get.to(ForgotPasswordScreen());
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (builder) =>
                              //             ForgotPassworScreen()));
                            },
                            child: Text(
                              "Forget Password",
                              style: Heading6Style(colorGreen),
                            )),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have account ? "),
                          TextButton(
                              onPressed: () {
                                Get.to(const RegistrationScreen());
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             RegistrationScreen()));
                              },
                              child: Text(
                                "sign up",
                                style: Heading6Style(colorGreen),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
