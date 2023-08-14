import 'package:all_flutter_project/Task%20Manager%20Project/style/Style.dart';
import 'package:all_flutter_project/Task%20Manager%20Project/widgets/ReUseAbleNewTask.dart';
import 'package:all_flutter_project/Task%20Manager%20Project/widgets/ReuseAbleElevatedButton.dart';
import 'package:flutter/material.dart';

class CancellTaskScreen extends StatefulWidget {
  const CancellTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancellTaskScreen> createState() => _CancellTaskScreenState();
}

class _CancellTaskScreenState extends State<CancellTaskScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ReUseAbleNewTask(
            Title: "This is title",
            Description: "This is Description",
            Date: "2-1-2000",
            Type: "Cancell",
            OnTapEdit: () {
              ShowModalSheetForStatus();
            },
            OnTapDelete: () {},
          );
        }


    );
  }


  void ShowModalSheetForStatus() {
    String type = "InProgress";
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
                      groupValue: type,
                      title: Text("InProgress"),
                      value: "InProgress",
                      onChanged: (value) {
                        type = value!;
                        changeState(() {});
                      }),
                  RadioListTile(
                      groupValue: type,
                      title: Text("Completed"),
                      value: "Completed",
                      onChanged: (value) {
                        type = value!;
                        changeState(() {});
                      }),
                  RadioListTile(
                      groupValue: type,
                      title: Text("Cancelled"),
                      value: "Cancelled",
                      onChanged: (value) {
                        type = value!;
                        changeState(() {});
                      }),
                  SizedBox(height: 20,),
                  ReUseAbleElevatedButton(
                      text: "Submit"
                      , onTap: () {}),
                ],
              ),
            );
          });
        });
  }
}
