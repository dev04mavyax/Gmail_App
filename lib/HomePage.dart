//
// import 'package:flutter/material.dart';
// import 'package:gmailapp/Home/ComposeEmailScreen.dart';
// import 'package:gmailapp/Home/HomeScreen.dart';
// import 'package:gmailapp/Home/Meeting.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   List<Widget> _screens = [GmailHomePage(), Meeting(),
//     // LeaderboardPage(),
// ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _screens,
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//     );
//   }
// }
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemTapped;
//
//   const CustomBottomNavigationBar({
//     Key? key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: InkWell(
//               onTap: () => onItemTapped(0),
//               child: _buildNavItem(
//                icon: Icons.email_rounded,
//
//                 isSelected: selectedIndex == 0,
//                 color: Colors.blue.shade50,
//               ),
//             ),
//           ),
//           Expanded(
//             child: InkWell(
//               onTap: () => onItemTapped(0),
//               child: _buildNavItem(
//                 icon: Icons.video_camera_front_outlined,
//
//                 isSelected: selectedIndex == 0,
//                 color: Colors.blue.shade50,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavItem({
//     required IconData icon,
//
//     required bool isSelected,
//     // required Function() onTap,
//     Color? color,
//   }) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(height: 8,),
//         Container(
//           // height: 47,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: isSelected? Colors.blue.shade50:Colors.white
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 2),
//           child: Column(
//             children: [
//               Icon(icon,size: 28,color: isSelected?Colors.black:Colors.grey.shade600,)
//             ],
//           ),
//         ),
//         SizedBox(height: 4,),
//
//       ],
//     );
//   }
// }
