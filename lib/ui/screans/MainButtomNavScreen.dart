import 'package:flutter/material.dart';

class Mainbuttomnavscreen extends StatelessWidget {
  const Mainbuttomnavscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              height: screenHeight,
              decoration: BoxDecoration(color: Color(0xff2370B4)),
              padding: EdgeInsets.only(top: 50, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monir Tea Stall',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '04 March, 2025',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        color: Colors.white,
                        icon: Image.asset('assets/icons/Language Switch.png'),
                      ),
                      SizedBox(width: 6),
                      IconButton(
                        onPressed: () {},
                        color: Colors.white,
                        icon: Image.asset(
                          'assets/icons/Notification Icon Container.png',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 120,
              right: 0,
              left: 0,
              child: SingleChildScrollView(
                child: Container(
                  // height: screenHeight - 150,
                  // padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xffE9F1F8),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        // padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          // borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                // Icon(Icons.arrow_downward, color: Colors.red),
                                Text(
                                  "মোট পাবে",
                                  style: TextStyle(color: Colors.green),
                                ),
                                Text(
                                  "৳50.00",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(height: 40, width: 1, color: Colors.grey),
                            Column(
                              children: [
                                // Icon(Icons.arrow_upward, color: Colors.green),
                                Text(
                                  "মোট দেবে",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text(
                                  "৳50.00",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: Offset(0, 3), // shadow position
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "খোঁজ",
                                    prefixIcon: Icon(Icons.search),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {},
                                color: Colors.grey,
                                icon: Image.asset('assets/icons/Filter.png'),
                              ),
                            ),
                            SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {},
                                color: Colors.grey,
                                icon: Image.asset(
                                  'assets/icons/Download Icon.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 230, 0),
                        child: Text(
                          "কাস্টমার / সাপ্লায়ার",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: 750,
                        child: ListView.builder(
                          itemCount: 8,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  "https://i.pravatar.cc/150?img=${index + 1}",
                                ),
                              ),
                              title: Text("আব্দুল্লাহ আল মামুন"),
                              subtitle: Text("আপডেট: আজ"),
                              trailing: Text(
                                index % 2 == 0 ? "৳50.00" : "৳0.00",
                                style: TextStyle(
                                  color:
                                      index % 2 == 0
                                          ? Colors.green
                                          : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/Group.png'),
          ),
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';

// class TeaStallDashboard extends StatelessWidget {
//   const TeaStallDashboard({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.blue,
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: 0,
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
//           items: [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: "হোম"),
//             BottomNavigationBarItem(icon: Icon(Icons.list), label: "লেনদেন"),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: "প্রোফাইল",
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {},
//           child: Icon(Icons.person_add_alt),
//           backgroundColor: Colors.blue,
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//         body: Stack(
//           children: [
//             // Top blue section
//             Container(
//               height: 170,
//               color: Colors.blue,
//               padding: EdgeInsets.only(top: 50, left: 20, right: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
                      
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.language, color: Colors.white),
//                       SizedBox(width: 12),
//                       Icon(Icons.notifications, color: Colors.white),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // White content section
//             Positioned(
//               top: 130,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//                 ),
//                 child: Column(
//                   children: [
//                     // Summary (Due and Pay)
//                     Container(
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Column(
//                             children: [
//                               Icon(Icons.arrow_downward, color: Colors.red),
//                               Text("মোট পাবে"),
//                               Text(
//                                 "৳50.00",
//                                 style: TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(height: 40, width: 1, color: Colors.grey),
//                           Column(
//                             children: [
//                               Icon(Icons.arrow_upward, color: Colors.green),
//                               Text("মোট দেবে"),
//                               Text(
//                                 "৳50.00",
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 12),

//                     // Search & Filter Row
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               hintText: "খোঁজ",
//                               prefixIcon: Icon(Icons.search),
//                               filled: true,
//                               fillColor: Colors.white,
//                               contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 16,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         CircleAvatar(
//                           backgroundColor: Colors.white,
//                           child: Icon(Icons.filter_list, color: Colors.grey),
//                         ),
//                         SizedBox(width: 8),
//                         CircleAvatar(
//                           backgroundColor: Colors.white,
//                           child: Icon(Icons.download, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 12),

//                     // Header Text
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "কাস্টমার / সাপ্লায়ার",
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                     SizedBox(height: 8),

//                     // List
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: 8,
//                         itemBuilder: (context, index) {
//                           return Card(
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                 backgroundImage: NetworkImage(
//                                   "https://i.pravatar.cc/150?img=${index + 1}",
//                                 ),
//                               ),
//                               title: Text("আব্দুল্লাহ আল মামুন"),
//                               subtitle: Text("আপডেট: আজ"),
//                               trailing: Text(
//                                 index % 2 == 0 ? "৳50.00" : "৳0.00",
//                                 style: TextStyle(
//                                   color:
//                                       index % 2 == 0
//                                           ? Colors.green
//                                           : Colors.red,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
