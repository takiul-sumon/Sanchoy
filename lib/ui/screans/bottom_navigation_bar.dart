import 'package:flutter/material.dart';
import 'package:sanchoy/ui/screans/MainButtomNavScreen.dart';
import 'package:sanchoy/ui/screans/side_menu.dart';

class BottomNaviationBar extends StatefulWidget {
  const BottomNaviationBar({super.key});

  @override
  State<BottomNaviationBar> createState() => _BottomNaviationBarState();
}

class _BottomNaviationBarState extends State<BottomNaviationBar> {
  int pageIndex = 0;

  final List<Widget> pages = [
    const Mainbuttomnavscreen(),
    const Mainbuttomnavscreen(),
    const Mainbuttomnavscreen(),
    const Sidemenu(),
  ];

  // CustomerDetailsPage(customerid: '2sVdvNslmB8olcKLiQHA')
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Image.asset('assets/icons/Home.png'),
            label: 'Transecion',
          ),
          NavigationDestination(
            icon: Image.asset('assets/icons/Default Icon.png'),
            label: 'CashBox',
          ),
          NavigationDestination(
            icon: Image.asset('assets/icons/Vector (1).png'),
            label: 'Report',
          ),
          NavigationDestination(
            icon: Image.asset('assets/icons/Vector (2).png'),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}




// IconButton _navIcon(
//     IconData selectedIcon,
//     IconData unselectedIcon,
//     int index,
//   ) {
//     return IconButton(
//       enableFeedback: false,
//       onPressed: () {
//         setState(() {
//           pageIndex = index;
//         });
//       },
//       icon: Icon(
//         pageIndex == index ? selectedIcon : unselectedIcon,
//         color: pageIndex == index ? Color(0xff2370B4) : Color(0xff000000),
//         size: 35,
//       ),
//     );
//   }




  // Container buildMyNavBar(BuildContext context) {
  //   return Container(
  //     height: 80,
  //     decoration: BoxDecoration(
  //       color: Color(0xffFFFFFF),
  //       borderRadius: const BorderRadius.only(
  //         topLeft: Radius.circular(25),
  //         topRight: Radius.circular(25),
  //       ),
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             _navIcon(Icons.home, Icons.home_outlined, 0),
  //             _navIcon(Icons.work_rounded, Icons.work_outline_outlined, 1),
  //             _navIcon(Icons.widgets_rounded, Icons.widgets_outlined, 2),
  //             _navIcon(Icons.person, Icons.person_outline, 3),
  //           ],
  //         ),
  //         SizedBox(height: 20),
  //       ],
  //     ),
  //   );
  // }