import 'dart:io';

import 'package:all_flutter_project/Task%20Manager%20Project/utils/UserData.dart';
import 'package:flutter/material.dart';

import '../style/Style.dart';
import '../widgets/BackGroundImage.dart';
import '../widgets/ReUseAbleAppBar.dart';
import '../widgets/ReuseAbleElevatedButton.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  TextEditingController EmailValue = TextEditingController();

  TextEditingController FirstNameValue = TextEditingController();

  TextEditingController LastNameValue = TextEditingController();

  TextEditingController MobileValue = TextEditingController();

  TextEditingController PasswordValue = TextEditingController();

  //image pic korar jonno PhotoFile name variable niyeci ata prothome null thakbe

  XFile? photoFile;
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    EmailValue.text = UserData.email ?? "";
    FirstNameValue.text = UserData.firstName ?? "";
    LastNameValue.text = UserData.lastName ?? "";
    MobileValue.text = UserData.phone ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReUseAbleAppBar(context, isTappAble: false),
        body: BackgroundImage(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Update Profile",
                    style: Heading1TextStyle(colorDarkBlue),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //Image Picker feild
                  //(InkWell)use kore onTap function use kora jai
                  InkWell(
                    onTap: () async {
                      final imagePicker = ImagePicker();
                      //ata async operation mane future a result dibe tai await use koreci
                      final result = await imagePicker.pickImage(
                          source: ImageSource.gallery);

                      if (result != null) {
                        photoFile = result;
                        setState(() {});
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              "Photo",
                              style: TextStyle(color: Colors.black),
                            ),
                            padding: EdgeInsets.all(12),
                            color: Colors.grey,
                          ),
                          /* je image nibo oi image ta box a show korbe
                          ata mobile kaj kore kintu web a error dei
                          tai comment kore rakhci
                          */

                          //visibility use kore konta kokhon visible hobe ar konta kokhon hobe na ta tik kore

                          Visibility(
                              /*
                           visible er vitor photofile null thakle nicher Select any Image ata dekhabe
                            */
                              replacement: const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Select any Image",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              visible: photoFile != null,
                              //akhane jokhon photo file er jodi not null hoi tahole image ta box er vitor dekhabe

                              child: Image.file(
                                File(photoFile?.path ?? ''),
                                width: 25,
                                height: 25,
                              )),

                          /*
                          PhotoFile null thakle empty string dekhabe
                           */
                          Expanded(
                              child: Text(
                            photoFile?.name ?? " ",
                            maxLines: 3,
                          )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    //Ay email show korbe kintu update kora jabe na khali read kora jabe
                    readOnly: true,
                    controller: EmailValue,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Email Required";
                      }

                      return null;
                    },
                    decoration: FormFeildStyle("Email"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: FirstNameValue,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "First Name Required";
                      }
                      return null;
                    },
                    decoration: FormFeildStyle("First Name"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: LastNameValue,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Last Name Required";
                      }
                      return null;
                    },
                    decoration: FormFeildStyle("Last Name"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    //Ay email show korbe kintu update kora jabe na khali read kora jabe
                    readOnly: true,

                    controller: MobileValue,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Mobile Number Required";
                      }
                      return null;
                    },
                    decoration: FormFeildStyle("Mobile"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: PasswordValue,
                    validator: (String? value) {
                      /*
                      user jodi password na dei tahole null value return korbe
                      and not empty thake tahole password er length 7 er chye kom dewa jabe
                      na
                       */
                      if ((value?.isNotEmpty ?? false) &&
                          //jodi input feild a 7 er cheye kon and equal value dei tahole nicher lekha show korbe
                          (value?.length ?? 0) <= 7) {
                        return "Please Enter Your Password in lenth more than 7";
                      }
                      return null;
                    },
                    decoration: FormFeildStyle("Password"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ReUseAbleElevatedButton(
                      text: "Update",
                      onTap: () {
                        if (_form.currentState!.validate()) {}
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
