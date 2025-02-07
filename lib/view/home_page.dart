import 'dart:core';

import 'package:egp_client/view/shop_list_page.dart';
import 'package:egp_client/view/stamp_management_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    ShopListPage(),
    StampManagementPage(),
    // UserProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(''),
        //   actions: [Icon(Icons.add), Icon(Icons.clear)],
        // ),
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.list), label: '店舗一覧'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'スタンプ'),
            // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
