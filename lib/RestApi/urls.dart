class urls {
  static String baseUrl = "https://task.teamrabbil.com/api/v1/";
  static String newTask = "$baseUrl/listTaskByStatus/New";
  static String completedTask = "$baseUrl/listTaskByStatus/Completed";
  static String Cancelled = "$baseUrl/listTaskByStatus/Cancelled";
  //ata holo arrow function
  static String changeStatus(String taskId, String status) =>
      "$baseUrl/updateTaskStatus/$taskId/$status";
}
