// import 'package:flutter/material.dart';
// import 'package:sanchoy/data/models/Urls.dart';
// import 'package:sanchoy/data/models/services/Newtork_client.dart';
// import 'package:sanchoy/ui/widgets/SnackBarMessenger.dart';

// class ConfirmationResetPasswordPage extends StatefulWidget {
//   const ConfirmationResetPasswordPage({
//     super.key,
//     required this.email,
//     required this.pin,
//   });
//   final String email;
//   final String pin;

//   @override
//   State<ConfirmationResetPasswordPage> createState() =>
//       _ConfirmationResetPasswordPageState();
// }

// class _ConfirmationResetPasswordPageState
//     extends State<ConfirmationResetPasswordPage> {
//   // final TextEditingController _setnewPasswordTECOntroller =
//   //     TextEditingController();
//   bool _getNewTaskInProgress = false;
//   // final TextEditingController _confirmNewPasswordTEController =
//   //     TextEditingController();
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             SizedBox(
//               height: 24,
//               child: Stack(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: IconButton(
//                       padding: EdgeInsets.zero,
//                       onPressed: () {},
//                       icon: Image.asset('assets/icons/Success Icon.png'),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Successful',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Align(
//               alignment: Alignment.center,
//               child: Image.asset('assets/images/undraw_confirmed_c5lo 1.png'),
//             ),

//             Text(
//               'Password Updated',
//               style: TextStyle(
//                 fontSize: 18,
//                 // fontWeight: FontWeight.bold,
//                 fontFamily: 'Poppins-Bold',
//               ),
//             ),
//             SizedBox(height: 10),
//             Text('Your password has been updated'),
//             const SizedBox(height: 20),

//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Sign In',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _resetPassword() async {
//     _getNewTaskInProgress = true;
//     setState(() {});

//     Map<String, dynamic> requestBody = {
//       "email": widget.email.trim(),
//       "OTP": widget.pin, // Make sure you have this variable in your widget
//       "password": _confirmNewPasswordTEController.text,
//     };

//     NetworkResponse response = await NetworkClient.postRequest(
//       url: Urls.recoveryResetPassword,
//       body: requestBody,
//     );

//     _getNewTaskInProgress = false;
//     setState(() {});

//     if (response.isSuccess) {
//       // Show success dialog
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Success"),
//             content: Text("Your password has been reset successfully."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close dialog
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );

//       showShackBarMessenger(context, "Successful");
//     } else {
//       showShackBarMessenger(context, response.errorMessage.toString(), true);
//     }
//   }
// }
