import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  final List<BottomNavigationBarItem> tabList = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
    ),
    const BottomNavigationBarItem(
      label: 'Messages',
      icon: Icon(Icons.message_outlined),
      activeIcon: Icon(Icons.message),
    ),
    const BottomNavigationBarItem(
      label: 'Profile',
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
    ),
  ];

  @override
  void onInit() {
    tabController = TabController(length: tabList.length, vsync: this);
    super.onInit();
  }
}