class Urls {
  static const String baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const String registerUrl = '$baseUrl/Registration';
  static const String loginUrl = '$baseUrl/Login';
  static const String updaterProfileUrl = '$baseUrl//ProfileUpdate';
  static String recoveryEmail(String email) =>
      '$baseUrl/RecoverVerifyEmail/$email';
  static String recoveryPin(String email, String pin) =>
      '$baseUrl/RecoverVerifyOtp/$email/$pin';

  static const String recoveryResetPassword = '$baseUrl/RecoverResetPassword';
}
