import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tezda/core/extensions/context_extensions.dart';
import 'package:tezda/core/routes/routes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.child});
  final Widget child;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const List<String> _tabs = [
    Routes.homeName,
    Routes.favouriteName,
    Routes.settingsName,
    // Routes.blogName,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _navigateWithCustomTransition(context, _tabs[index]);
  }

  void _navigateWithCustomTransition(BuildContext context, String routeName) {
    context.goNamed(
      routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: context.primaryColor,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
