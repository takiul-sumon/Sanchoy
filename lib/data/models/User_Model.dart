class UserModel {
  late final String id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String mobile;
  late final String createdDate;
  late final String photo;
  // UserModel({
  //   required this.id,
  //   required this.email,
  //   required this.firstName,
  //   required this.lastName,
  //   required this.mobile,
  //   required this.createdDate,
  // });

  UserModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['_id'] ?? '';
    email = jsonData['email'] ?? '';
    firstName = jsonData['firstName'] ?? '';
    lastName = jsonData['lastName'] ?? '';
    mobile = jsonData['mobile'] ?? '';
    createdDate = jsonData['createdDate'] ?? '';
    photo = jsonData['photo'] ?? '';
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'createdDate': createdDate,
    };
  }

  String get fullName {
    return '$firstName $lastName';
  }

  // String get getPhoto {
  //   return photo;
  // }
}

// class UserModel {
//   final String id;
//   final String email;
//   final String firstName;
//   final String lastName;
//   final String mobile;
//   final String createdDate;
//   UserModel({
//     required this.id,
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     required this.mobile,
//     required this.createdDate,
//   });

//   factory UserModel.conertJspnToDart(Map<String, dynamic> jsonData) {
//     return UserModel(

//       id = jsonData['_id'] ?? '',
//     email = jsonData['email'] ?? '',
//     firstName = jsonData['firstName'] ?? '',
//     lastName = jsonData['lastName'] ?? '',
//     mobile = jsonData['mobile'] ?? '',
//     createdDate = jsonData['createdDate'] ?? '';);
//   }
// }
