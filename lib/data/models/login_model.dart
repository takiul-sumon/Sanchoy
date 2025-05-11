
import 'package:sanchoy/data/models/User_Model.dart';

class LoginModel {
  late final String status;
  late final String token;
  late final UserModel userModel;
  LoginModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'] ?? '';
    userModel = UserModel.fromJson(jsonData['data'] ?? {});
    token = jsonData['token'] ?? '';
  }
}
