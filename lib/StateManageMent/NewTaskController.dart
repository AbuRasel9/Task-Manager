import 'package:get/get.dart';

import '../RestApi/RestApi.dart';
import '../models/NewTaskModel.dart';

class NewTaskController extends GetxController{
  //inprogress er jonno
  bool _inProgress=false;
  NewTaskModel1? _newTaskModel;
  //user jeno data gula only get korte pare
  NewTaskModel1? get newTaskModel=>_newTaskModel;
  //User inprogress dekhte parbe
  bool get inprogress=>_inProgress;



  //api call kore dekhbo koita new task ase

  Future<void> getNewTaskFormApi() async {
    _inProgress=true;

    var urls;
    final response = await GetMethodRequester().getRequest(urls.newTask);
    if (response['status'] == 'success') {
      _newTaskModel = NewTaskModel1.fromJson(response);

      _inProgress=false;
      update();
    }
  }

}