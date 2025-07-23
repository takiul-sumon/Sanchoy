// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class ForgetPinverificationwithemail extends StatelessWidget {
//   ForgetPinverificationwithemail({super.key, required this.email});
//   final TextEditingController _pincodeTEController = TextEditingController();
//   final String email;

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
//                       'Enter OTP Code',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Align(
//               alignment: Alignment.center,
//               child: Image.asset('assets/images/undraw_completing_gsf8 1.png'),
//             ),
//             PinCodeTextField(
//               appContext: context,
//               controller: _pincodeTEController,
//               pastedTextStyle: TextStyle(
//                 color: Colors.green.shade600,
//                 fontWeight: FontWeight.bold,
//               ),
//               length: 6,
//               keyboardType: TextInputType.number,

//               backgroundColor: Colors.transparent,
//               blinkWhenObscuring: true,
//               animationType: AnimationType.fade,
//               validator: (v) {
//                 if (v!.length < 3) {
//                   return "I'm from validator";
//                 } else {
//                   return null;
//                 }
//               },
//               pinTheme: PinTheme(
//                 shape: PinCodeFieldShape.box,
//                 borderRadius: BorderRadius.circular(5),
//                 fieldHeight: 50,
//                 fieldWidth: 40,
//                 activeFillColor: Colors.white,
//               ),
//             ),

//             Text(
//               'We sent a four digits OTP code to your phone\n number 018xxxxxxxx. You can check your\n                            message',
//               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 20),
//             TextFormField(
//               decoration: InputDecoration(
//                 hintText: 'Email',
//                 prefixIcon: Image.asset('assets/icons/Iphone.png'),
//               ),
//             ),
//             TextButton(
//               onPressed: () {},
//               child: Text(
//                 'I didn’t receive the code? Send again',
//                 style: TextStyle(color: Color(0xff0F2F4C)),
//               ),
//             ),

//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Verify',
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
