import 'package:crowd_counting_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'camera_upload_page.dart';

class DashboardPage extends StatefulWidget {
  final int initialPage;
  final Widget? child;
  const DashboardPage({this.initialPage = 0, this.child, super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [HomePage(), CameraUploadPage(), ProfilePage()];
  final List<String> _titles = ['Home', 'CrowdIQ', 'Profil'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex]), backgroundColor: AppColors.primary, foregroundColor: AppColors.background, centerTitle: true),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'CrowdIQ',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
