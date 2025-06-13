import 'package:flutter/material.dart';
import '../../pages/main_page.dart';
import '../../features/mission/pages/mission_list_page.dart';
import '../../features/reward/pages/reward_page.dart';
import '../../features/community/pages/community_page.dart';
import '../../features/profile/pages/my_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 2; // 홈 페이지를 기본으로 설정

  final List<Widget> _pages = [
    const MissionListPage(),
    const RewardPage(),
    const MainPage(),
    const CommunityPage(),
    const MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: '미션 목록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: '리워드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이',
          ),
        ],
      ),
    );
  }
} 