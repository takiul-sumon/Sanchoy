class Urls {
  static const String baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const String registerUrl = '$baseUrl/Registration';
  static const String loginUrl = '$baseUrl/Login';
  static const String updaterProfileUrl = '$baseUrl//ProfileUpdate';

  static const String createTask = '$baseUrl/createTask';
  static const String taskStatusCountUrl = '$baseUrl/taskStatusCount';
  static const String newtaskListCountUrl = '$baseUrl/listTaskByStatus/New';
  static const String progresstaskListCountUrl =
      '$baseUrl/listTaskByStatus/Progress';

  static const String cancelledTaskListUrl =
      '$baseUrl/listTaskByStatus/Cancelled';

  static const String completedTaskListUrl =
      '$baseUrl/listTaskByStatus/Completed';
  static String updateTaskStatusUrl(String taskId, String status) =>
      '$baseUrl/updateTaskStatus/$taskId/$status';
  static String deleteTaskUrl(String taskId) => '$baseUrl/deleteTask/$taskId';
  static String recoveryEmail(String email) =>
      '$baseUrl/RecoverVerifyEmail/$email';
  static String recoveryPin(String email, String pin) =>
      '$baseUrl/RecoverVerifyOtp/$email/$pin';

  static const String recoveryResetPassword = '$baseUrl/RecoverResetPassword';
}
