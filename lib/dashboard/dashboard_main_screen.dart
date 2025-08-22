// dashboard_main_screen.dart
import 'package:cef_dashboard/dashboard/blog_widget.dart';
import 'package:cef_dashboard/dashboard/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../my courses/my_courses_screen.dart';
import '../my courses/self_learning_courses.dart'; // Import CourseModel
import '../my courses/course_details_screen.dart'; // Import CourseDetailsScreen
import 'class_details_widget.dart';
import 'my_schedule_widget.dart';
import 'overview_details_widget.dart';
import 'enroll_courses_widget.dart';

class DashboardMainScreen extends StatefulWidget {
  const DashboardMainScreen({super.key});

  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 1;
  CourseModel? _selectedCourse; // Track selected course

  Widget _buildWebAppBarItem(String text, int index) {
    return TextButton(
      onPressed: () {
        if (index == 0) { // HOME index
          _launchURL('https://cefonlineacademy.com/');
        } else {
          setState(() {
            _selectedIndex = index;
            _selectedCourse = null;
          });
        }
      },
      style: TextButton.styleFrom(
        foregroundColor: _selectedIndex == index ? Colors.blue[800] : Colors.black,
        textStyle: TextStyle(
          fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      child: Text(text),
    );
  }

  // Method to launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Widget? drawerWidget = constraints.maxWidth <= 600
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
              ListTile(
                  title: Text('HOME'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                      _selectedCourse = null; // Reset selected course
                    });
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text('DASHBOARD'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                      _selectedCourse = null; // Reset selected course
                    });
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text('MY COURSES'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                      _selectedCourse = null; // Reset selected course
                    });
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text('CLASS SCHEDULE'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                      _selectedCourse = null; // Reset selected course
                    });
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text('CLASS HISTORY'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 4;
                      _selectedCourse = null; // Reset selected course
                    });
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text('MY PRODUCTS'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 5;
                      _selectedCourse = null; // Reset selected course
                    });
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text('BILLING'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 6;
                      _selectedCourse = null; // Reset selected course
                    });
                    Navigator.pop(context);
                  }),
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
            : null;

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
                    child: Image.asset('assets/images/cef_logo.png', height: 50), // Replace with your logo asset
                  ),
                  SizedBox(width: 20),
                  Row(
                    children: [
                      _buildWebAppBarItem('HOME', 0),
                      _buildWebAppBarItem('DASHBOARD', 1),
                      _buildWebAppBarItem('MY COURSES', 2),
                      _buildWebAppBarItem('CLASS SCHEDULE', 3),
                      _buildWebAppBarItem('CLASS HISTORY', 4),
                      _buildWebAppBarItem('MY PRODUCTS', 5),
                      _buildWebAppBarItem('BILLING', 6),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 170,
                          height: 40,
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
                child: Image.asset('assets/images/cef.png', height: 60), // Replace with your logo asset
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
          body: _selectedIndex == 2
              ? _selectedCourse != null
              ? CourseDetailsScreen(
            course: _selectedCourse!,
            onBack: () {
              setState(() {
                _selectedCourse = null; // Return to MyCoursesWidget
              });
            },
          )
              : MyCoursesWidget(
            onCourseSelected: (CourseModel course) {
              setState(() {
                _selectedCourse = course; // Set selected course
              });
            },
            onBackPressed: () {
              setState(() {
                _selectedIndex = 1; // Navigate back to Dashboard (index 1)
                _selectedCourse = null;
              });
            },
          )

              : SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // Web view layout
                  return Column(
                    children: [
                      const WelcomeBannerWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: ClassDetailsWidget()),
                                    Expanded(child: OverviewDetailsWidget()),
                                  ],
                                ),
                                EnrollCoursesWidget(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: MyScheduleWidget(),
                                ),
                                BlogWidget(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  // Mobile view layout
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const WelcomeBannerWidget(),
                      SizedBox(height: 10),
                      ClassDetailsWidget(),
                      OverviewDetailsWidget(),
                      MyScheduleWidget(),
                      EnrollCoursesWidget(),
                      BlogWidget(),
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