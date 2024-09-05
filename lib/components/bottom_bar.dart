import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For HapticFeedback
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

// class _BottomNavBarState extends State<BottomNavBar> {
//   void _onItemTapped(int index) {
//     if (index == widget.currentIndex) {
//       // If the tapped icon is already active, do nothing.
//       return;
//     }
//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomePage()),
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => SearchPage()),
//         );
//         break;
//       case 2:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => AnalysisPage()),
//         );
//         break;
//       case 3:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => ProfilePage()),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       height: 45,
//       shape: const CircularNotchedRectangle(),
//       notchMargin: 10.0,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             icon: Icon(
//               Icons.home,
//               color: widget.currentIndex == 0 ? Colors.blue : Colors.grey,
//             ),
//             onPressed: () => _onItemTapped(0),
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.search,
//               color: widget.currentIndex == 1 ? Colors.blue : Colors.grey,
//             ),
//             onPressed: () => _onItemTapped(1),
//           ),
//           const SizedBox(width: 5), // Space for the floating action button
//           IconButton(
//             icon: Icon(
//               Icons.analytics,
//               color: widget.currentIndex == 2 ? Colors.blue : Colors.grey,
//             ),
//             onPressed: () => _onItemTapped(2),
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.person,
//               color: widget.currentIndex == 3 ? Colors.blue : Colors.grey,
//             ),
//             onPressed: () => _onItemTapped(3),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _BottomNavBarState extends State<BottomNavBar> {
  void _onItemTapped(int index) {
    if (index == widget.currentIndex) {
      return;
    }
    // Trigger vibration when icon is tapped
    HapticFeedback.lightImpact();

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
      height: 40,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(icon: Icons.home, index: 0),
          _buildNavItem(icon: Icons.search, index: 1),
          const SizedBox(width: 5), // Space for the floating action button
          _buildNavItem(icon: Icons.analytics, index: 2),
          _buildNavItem(icon: Icons.person, index: 3),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
        color: Colors.transparent,
        child: Icon(
          icon,
          color: widget.currentIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}

