import 'package:flutter/material.dart';
import 'package:bite_zone/providers/theme_provider.dart';
import 'package:bite_zone/themes/themes.dart';
import 'package:provider/provider.dart';

class ThemeChange extends StatefulWidget {
  const ThemeChange({super.key});

  @override
  State<ThemeChange> createState() => _ThemeChangeState();
}

class _ThemeChangeState extends State<ThemeChange> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Theme'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: orangeTheme.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: const Text('Orange Theme'),
            onTap: () {
              themeProvider.setTheme(orangeTheme, ThemeMode.light);
            },
          ),
          ListTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: greenTheme.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: const Text('Green Theme'),
            onTap: () {
              themeProvider.setTheme(greenTheme, ThemeMode.light);
            },
          ),
          ListTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: darkAshTheme.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: const Text('Dark Theme'),
            onTap: () {
              themeProvider.setTheme(darkAshTheme, ThemeMode.dark);
            },
          ),
          ListTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: purpleTheme.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: const Text('Purple Theme'),
            onTap: () {
              themeProvider.setTheme(purpleTheme, ThemeMode.light);
            },
          ),
          ListTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: yellowTheme.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: const Text('Yellow Theme'),
            onTap: () {
              themeProvider.setTheme(yellowTheme, ThemeMode.light);
            },
          ),
        ],
      ),
    );
  }
}