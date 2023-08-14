import 'package:all_flutter_project/Task%20Manager%20Project/RestApi/RestApi.dart';
import 'package:all_flutter_project/Task%20Manager%20Project/RestApi/urls.dart';
import 'package:all_flutter_project/Task%20Manager%20Project/models/NewTaskModel.dart';
import 'package:all_flutter_project/Task%20Manager%20Project/widgets/ReUseAbleNewTask.dart';
import 'package:flutter/material.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
  
}


class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  NewTaskModel1 ?_newTaskModel1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CompleteTask();

    });

  }
  
  Future<void>CompleteTask() async {
    final response=await GetMethodRequester().getRequest(urls.completedTask);
    if(response["status"]=="success"){
      _newTaskModel1=NewTaskModel1.fromJson(response);
      setState(() {

      });

    }


  }
  
  @override
  Widget build(BuildContext context) {
    
    
    
    return ListView.builder(
        itemCount: _newTaskModel1?.Task?.length ?? 0,
        itemBuilder: (context,index){
          final task=_newTaskModel1?.Task![index];
          return ReUseAbleNewTask(
            Title: task?.title,
            Description: task?.description,
            Date: task?.createdDate,
            Type: task?.status,
            OnTapEdit: () {},
            OnTapDelete: (){},
          );

    }


    );
    
  }
}
