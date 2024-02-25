import 'package:countdown_app/presentation/third_page.dart';
import 'package:flutter/material.dart';
import 'package:countdown_app/domain/nav_bar.dart';
import 'package:countdown_app/presentation/home_page.dart';
import 'package:countdown_app/presentation/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  int _selectedIndex = 0;

  final user = FirebaseAuth.instance.currentUser!;

  void _onItemTapped(int index) {
    // if (index == 1) {
    //   showModalBottomSheet(
    //     enableDrag: false,
    //     isDismissible: false,
    //     isScrollControlled: true,
    //     useSafeArea: true,
    //     backgroundColor: Colors.transparent,
    //     context: context, 
    //     builder: (context) => CreatePage(),
    //   );
    //   return;
    // }

    setState(() {
      _selectedIndex = index;
    });
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_2_outlined, size: 50,),
                    Text(user.email!),
                  ],
                ),
              ),

              const ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),

              const ListTile(
                leading: Icon(Icons.list),
                title: Text("Countdowns"),
              ),

              const ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: signUserOut,
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
                  SearchPage(),
                  ThirdPage(),
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