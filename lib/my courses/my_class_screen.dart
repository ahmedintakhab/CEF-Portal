import 'package:flutter/material.dart';

import '../myClass Tabs/current_class_screen.dart';
import '../myClass Tabs/past_class_screen.dart';
import '../myClass Tabs/upcoming_class_screen.dart';

class MyClassScreen extends StatefulWidget {
  final String courseName;

  const MyClassScreen({super.key, required this.courseName});

  @override
  State<MyClassScreen> createState() => _MyClassScreenState();
}

class _MyClassScreenState extends State<MyClassScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              height: 54,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF23408F).withOpacity(0.14),
                    offset: const Offset(-4, 5),
                    blurRadius: 16,
                  ),
                ],
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: const Color(0xFF6E758A),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                  labelStyle: const TextStyle(
                    color: Color(0xFF23408F),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'Gilroy',
                  ),
                  labelColor: const Color(0xFF78A02A),
                  unselectedLabelStyle: const TextStyle(
                    color: Color(0xFF23408F),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'Gilroy',
                  ),
                  indicator: ShapeDecoration(
                    color: const Color(0xFFEBF2C2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: "Upcoming"),
                    Tab(text: "Current"),
                    Tab(text: "Past"),
                  ],
                  onTap: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  _tabController.animateTo(index);
                },
                children: const [
                  UpcomingClassScreen(),
                  CurrentClassScreen(),
                  PastClassScreen(),
                ],
              ),
            ),
          ],
        ),
    );
  }
}