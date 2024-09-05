// import 'package:flutter/material.dart';
// import 'package:optiparser/screens/analysispage.dart';
// import 'package:optiparser/screens/homepage.dart';
// import 'package:optiparser/screens/searchpage.dart';
// import 'package:optiparser/screens/profilepage.dart';

// BottomAppBar buildBottomNavBar(BuildContext context) {
//   return BottomAppBar(
//     height: 40,
//     shape: const CircularNotchedRectangle(),
//     notchMargin: 10.0,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         IconButton(
//           // padding: EdgeInsets.all(10),
//           icon: const Icon(Icons.home),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage()),
//             );
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.search),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => SearchPage()),
//             );
//           },
//         ),
//         const SizedBox(width: 10), // Space for the floating action button
//         IconButton(
//           icon: const Icon(Icons.analytics),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => AnalysisPage()),
//             );
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.person),
//           onPressed: () { Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ProfilePage()),
//             );},
//         ),
//       ],
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:optiparser/screens/analysispage.dart';
import 'package:optiparser/screens/homepage.dart';
import 'package:optiparser/screens/searchpage.dart';
import 'package:optiparser/screens/profilepage.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void _onItemTapped(int index) {
    if (index == widget.currentIndex) {
      // If the tapped icon is already active, do nothing.
      return;
    }
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AnalysisPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 45,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: widget.currentIndex == 0 ? Colors.blue : Colors.grey,
            ),
            onPressed: () => _onItemTapped(0),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: widget.currentIndex == 1 ? Colors.blue : Colors.grey,
            ),
            onPressed: () => _onItemTapped(1),
          ),
          const SizedBox(width: 10), // Space for the floating action button
          IconButton(
            icon: Icon(
              Icons.analytics,
              color: widget.currentIndex == 2 ? Colors.blue : Colors.grey,
            ),
            onPressed: () => _onItemTapped(2),
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: widget.currentIndex == 3 ? Colors.blue : Colors.grey,
            ),
            onPressed: () => _onItemTapped(3),
          ),
        ],
      ),
    );
  }
}
