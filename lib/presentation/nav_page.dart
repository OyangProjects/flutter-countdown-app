import 'package:flutter/material.dart';
import 'package:countdown_app/domain/nav_bar.dart';
import 'package:countdown_app/presentation/create_page.dart';
import 'package:countdown_app/presentation/home_page.dart';
import 'package:countdown_app/presentation/search_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("App Bar")),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.zero,
                height: 170.0,
                width: double.infinity,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_2_outlined, size: 50,),
                    Text("Username"),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text("Countdowns"),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: IndexedStack(
                index: _selectedIndex,
                children: const [
                  HomePage(),
                  CreatePage(),
                  SearchPage(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}