import 'package:bite_zone/screens/common_screens/theme_change.dart';
import 'package:bite_zone/screens/user_screens/user_favorite_screen.dart';
import 'package:bite_zone/screens/user_screens/user_trending_screen.dart';
import 'package:bite_zone/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'user_home_screen.dart';
import '../common_screens/profile_screen.dart';
import 'user_news_screen.dart';

class UserRouterScreen extends StatefulWidget {
  @override
  _UserRouterScreenState createState() => _UserRouterScreenState();
}

class _UserRouterScreenState extends State<UserRouterScreen> {
  final AuthService _authService = AuthService();
  int _selectedIndex = 2;

  final List<Widget> _screens = [
    const UserTrendingScreen(),
    const UserFavoriteScreen(),
    const UserHomeScreen(),
    const UserNewsScreen(),
    ProfileScreen(),
  ];

  static const List<String> _titles = <String>[
    'Trending Now',
    'Your Favorites',
    'Discover Culinary Delights',
    'Food & Drink News',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _handleLogout() async {
    bool? confirmLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Cancel',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Logout',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
          ],
        );
      },
    );

    if (confirmLogout == true) {
      await _authService.logout();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'logout') {
                _handleLogout();
              } else if (result == 'theme') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThemeChange(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'theme',
                child: Container(
                  width: 140,
                  height: 35,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.color_lens,
                          color: Theme.of(context).iconTheme.color),
                      SizedBox(width: 10),
                      Text('Themes'),
                    ],
                  ),
                ),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: Container(
                  width: 140,
                  height: 35,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.logout,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(width: 10),
                      Text('Logout'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        iconSize: 24,
        selectedIconTheme: const IconThemeData(
          size: 32,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 24,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
