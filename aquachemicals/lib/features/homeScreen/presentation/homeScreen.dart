import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'selfserve/selfserve.dart';
import 'request/request.dart';
import 'teamleaves/teamleaves.dart';
import 'settings/settings.dart';
import 'package:aquachemicals/ui/color/appColor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const SelfServe(),
    const RequestPage(),
     TeamLeaves(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: AppColors.blues,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.6),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.hourglass_empty),
          label: 'Request',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.handshake), // Utilities page icon
          label: 'Team',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _pageIndex,
      onTap: (index) {
        if (index != 4) { // Disabling Profile Page
          _onItemTapped(index);
        }
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }
}
