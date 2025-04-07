import 'dart:core';

import 'package:egp_client/view/setting_page.dart';
import 'package:egp_client/view/shop_list_page.dart';
import 'package:egp_client/view/stamp_management_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/config.dart';
import '../icon/custom_icons.dart' as custom_icon;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  final List<dynamic> _items = [
    {
      'icon': Icons.list,
      'label': '店舗情報',
      'color': Colors.amberAccent,
    },
    {
      'icon': custom_icon.Custom.stamp,
      'label': 'スタンプ',
      'color': Colors.amberAccent,
    },
    {
      'icon': Icons.settings,
      'label': '設定',
      'color': Colors.yellow,
    },
  ];

  static final List<Widget> _widgetOptions = <Widget>[
    ShopListPage(),
    StampManagementPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: _widgetOptions.elementAt(_currentIndex)),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < _items.length; i++) ...{
                _buildTabItem(i, _items[i]['icon'], _items[i]['label'],
                    _items[i]['color'])
              }
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(
      int index, IconData icon, String label, Color selectedColor) {
    final isSelected = index == _currentIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / _items.length,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: Config.iconSizeMiddleSmall,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: Config.fontSizeSmall,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
