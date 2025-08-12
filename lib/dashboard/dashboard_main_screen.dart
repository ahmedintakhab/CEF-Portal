import 'package:flutter/material.dart';

import 'class_details_widget.dart';
import 'my_schedule_widget.dart';
import 'overview_details_widget.dart';

class DashboardMainScreen extends StatefulWidget {
  const DashboardMainScreen({super.key});

  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Widget drawerWidget = constraints.maxWidth <= 600
            ? Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person),
                    ),
                    SizedBox(height: 10),
                    Text('User Name', style: TextStyle(color: Colors.white, fontSize: 18)),
                    Text('user@example.com', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              ListTile(title: Text('HOME'), onTap: () {}),
              ListTile(title: Text('DASHBOARD'), onTap: () {}),
              ListTile(title: Text('MY COURSES'), onTap: () {}),
              ListTile(title: Text('CLASS SCHEDULE'), onTap: () {}),
              ListTile(title: Text('CLASS HISTORY'), onTap: () {}),
              ListTile(title: Text('MY PRODUCTS'), onTap: () {}),
              ListTile(title: Text('BILLING'), onTap: () {}),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {},
              ),
            ],
          ),
        )
            : SizedBox.shrink();

        return Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              title: constraints.maxWidth > 600
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/cef.png', height: 40), // Replace with your logo asset
                  ),
                  SizedBox(width: 20),
                  Row(
                    children: [
                      TextButton(onPressed: () {}, child: Text('HOME')),
                      TextButton(onPressed: () {}, child: Text('DASHBOARD')),
                      TextButton(onPressed: () {}, child: Text('MY COURSES')),
                      TextButton(onPressed: () {}, child: Text('CLASS SCHEDULE')),
                      TextButton(onPressed: () {}, child: Text('CLASS HISTORY')),
                      TextButton(onPressed: () {}, child: Text('MY PRODUCTS')),
                      TextButton(onPressed: () {}, child: Text('BILLING')),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 150,
                          height: 45,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.notifications),
                          onPressed: () {
                            // Handle notification action
                          },
                        ),
                        PopupMenuButton<String>(
                          icon: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          onSelected: (String value) {
                            if (value == 'profile') {
                              // Handle profile action
                            } else if (value == 'logout') {
                              // Handle logout action
                            }
                          },
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'profile',
                              child: ListTile(
                                leading: Icon(Icons.person),
                                title: Text('Profile'),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'logout',
                              child: ListTile(
                                leading: Icon(Icons.logout),
                                title: Text('Logout'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  : null,
              leading: constraints.maxWidth <= 600
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/cef.png', height: 40), // Replace with your logo asset
              )
                  : null,
              actions: constraints.maxWidth <= 600
                  ? [
                Container(
                  width: 150,
                  height: 45,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    // Handle notification action
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    child: IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  ),
                ),
              ]
                  : null,
            ),
          ),
          drawer: drawerWidget,
          body: SingleChildScrollView(

            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: ClassDetailsWidget()),
                      Expanded(child: OverviewDetailsWidget()),
                      Expanded(child: MyScheduleWidget()),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      ClassDetailsWidget(),
                      OverviewDetailsWidget(),
                      MyScheduleWidget(),
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}