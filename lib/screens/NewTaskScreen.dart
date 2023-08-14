import 'package:all_flutter_project/Task%20Manager%20Project/RestApi/RestApi.dart';
import 'package:all_flutter_project/Task%20Manager%20Project/RestApi/urls.dart';
import 'package:all_flutter_project/Task%20Manager%20Project/StateManageMent/NewTaskController.dart';
import 'package:all_flutter_project/Task%20Manager%20Project/models/NewTaskModel.dart';
import 'package:all_flutter_project/Task%20Manager%20Project/style/Style.dart';
import 'package:all_flutter_project/Task%20Manager%20Project/widgets/ReUseAbleNewTask.dart';
import 'package:all_flutter_project/Task%20Manager%20Project/widgets/ReuseAbleElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/ReUseAbleCard1.dart';
import 'package:logger/logger.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final newTaskController=Get.put(NewTaskController());

  @override
  void initState() {
    super.initState();



    /*
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {}
    ata use korle age build method ta build hoice tar por api call hoice


     */
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      newTaskController.getNewTaskFormApi();
    });
  }




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.greenAccent,
          child: Row(
            children: [
              Expanded(child: ReUseAbleCard(23, "New")),
              Expanded(child: ReUseAbleCard(23, "Complete")),
              Expanded(child: ReUseAbleCard(23, "Cancell")),
              Expanded(child: ReUseAbleCard(23, "InProgress")),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),

        GetBuilder<NewTaskController>(
          init: NewTaskController(),
            builder: (controller){
            if(controller.inprogress==true){
              return Expanded(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );

            }else{
              return Expanded(
                  child: RefreshIndicator(
                    onRefresh: ()async{
                      controller. getNewTaskFormApi();
                    },
                    child: ListView.builder(
                        itemCount:newTaskController.newTaskModel?.Task?.length ?? 0,
                        itemBuilder: (context, index) {
                          final task =newTaskController.newTaskModel?.Task![index];
                          return ReUseAbleNewTask(
                            //jodi value na thake tahole unknown dekhabe
                              Title: task?.title ?? 0,
                              Description: task?.description,
                              Type: task?.status,
                              Date: task?.createdDate,
                              OnTapEdit: () {
                                ShowModalSheetForStatus(task?.sId ?? '');
                              },
                              OnTapDelete: () {


                              });
                        }),
                  ));


            }

        })


      ],
    );
  }

  void ShowModalSheetForStatus(taskId) {
    bool Inprogress = false;

    String taskStatus = "InProgress";
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, changeState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Change Status Of Task",
                    style: Heading1TextStyle(colorDarkBlue),
                  ),
                  RadioListTile(
                      groupValue: taskStatus,
                      title: Text("InProgress"),
                      value: "InProgress",
                      onChanged: (value) {
                        taskStatus = value!;
                        changeState(() {});
                      }),
                  RadioListTile(
                      groupValue: taskStatus,
                      title: Text("Completed"),
                      value: "Completed",
                      onChanged: (value) {
                        taskStatus = value!;
                        changeState(() {});
                      }),
                  RadioListTile(
                      groupValue: taskStatus,
                      title: const Text("Cancelled"),
                      value: "Cancelled",
                      onChanged: (value) {
                        taskStatus = value!;
                        changeState(() {});
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  if (Inprogress)
                    const Center(
                       child: CircularProgressIndicator(),
                    )
                  else
                    ReUseAbleElevatedButton(

                        text: "Submit",
                        onTap: () async {
                          Inprogress=true;
                          changeState((){});
                          final response = await GetMethodRequester()
                              .getRequest(
                                  urls.changeStatus(taskId, taskStatus));
                          Inprogress=false;
                          changeState((){});
                          if (response["status"] == "success") {
                            newTaskController.getNewTaskFormApi();
                            ToastMessage("Status Update Successfull");
                             Navigator.pop(context);
                          } else {
                            ToastMessage("Status Update Failed");
                          }
                        }),
                ],
              ),
            );
          });
        });
  }
}
